import '../models/transaction_type_model.dart';
import '../config/database_helper.dart';
import '../config/database_table.dart';
import '../services/transaction_type_database.dart';

class TransactionTypeRepository {
  final _dbHelper = DatabaseHelper();

  /// Create a new transaction type
  Future<int> createTransactionType({
    required String name,
    String? createdAt,
  }) async {
    return await TransactionTypeDatabase.createTransactionType(
      name: name,
      createdAt: createdAt,
    );
  }

  /// Retrieve all transaction types
  Future<List<TransactionTypeModel>> getAllTransactionTypes() async {
    final result = await TransactionTypeDatabase.getAllTransactionTypes();

    // Convert each row in the result to a TransactionTypeModel object
    return result.map((json) => TransactionTypeModel.fromJson(json)).toList();
  }

  /// Retrieve a specific transaction type by ID
  Future<TransactionTypeModel?> getTransactionTypeById(int id) async {
    final result = await TransactionTypeDatabase.getTransactionTypeById(id);

    if (result != null) {
      return TransactionTypeModel.fromJson(result);
    }
    return null;
  }

  /// Retrieve a transaction type by its name
  Future<TransactionTypeModel?> getTransactionTypeByName(String name) async {
    final db = await _dbHelper.database;

    final result = await db.query(
      DatabaseTable.transactionType,
      where: 'name = ?',
      whereArgs: [name],
    );

    if (result.isNotEmpty) {
      return TransactionTypeModel.fromJson(result.first);
    }
    return null;
  }

  /// Update a transaction type
  Future<int> updateTransactionType({
    required int id,
    String? name,
    String? createdAt,
  }) async {
    return await TransactionTypeDatabase.updateTransactionType(
      id: id,
      name: name,
      createdAt: createdAt,
    );
  }

  /// Delete a transaction type
  Future<int> deleteTransactionType(int id) async {
    return await TransactionTypeDatabase.deleteTransactionType(id);
  }
}
