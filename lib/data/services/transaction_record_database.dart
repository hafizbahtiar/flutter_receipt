import 'package:intl/intl.dart';
import '../config/database_helper.dart';
import '../config/database_table.dart';
import '../models/transaction_record_model.dart';

class TransactionRecordDatabase {
  static final _dbHelper = DatabaseHelper();

  /// Create a new transaction record
  static Future<int> createTransactionRecord({
    required int categoryId,
    required int transactionTypeId,
    required String transactionTypeName,
    required double amount,
    String? description,
    String? createdAt,
  }) async {
    final db = await _dbHelper.database;

    final data = {
      'category_id': categoryId,
      'transaction_type_id': transactionTypeId,
      'transaction_type_name': transactionTypeName,
      'amount': amount,
      'description': description,
      'created_at': createdAt ?? DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
    };

    return await db.insert(DatabaseTable.transactionRecord, data);
  }

  /// Retrieve all transaction records
  static Future<List<TransactionRecordModel>> getAllTransactionRecords() async {
    final db = await _dbHelper.database;

    final result = await db.query(
      DatabaseTable.transactionRecord,
      orderBy: 'created_at DESC',
    );

    return result.map((e) => TransactionRecordModel.fromJson(e)).toList();
  }

  /// Retrieve a specific transaction record by ID
  static Future<TransactionRecordModel?> getTransactionRecordById(int id) async {
    final db = await _dbHelper.database;

    final result = await db.query(
      DatabaseTable.transactionRecord,
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.isNotEmpty ? TransactionRecordModel.fromJson(result.first) : null;
  }

  /// Retrieve all transaction records for a specific category
  static Future<List<TransactionRecordModel>> getTransactionRecordsByCategory(int categoryId) async {
    final db = await _dbHelper.database;

    final result = await db.query(
      DatabaseTable.transactionRecord,
      where: 'category_id = ?',
      whereArgs: [categoryId],
      orderBy: 'created_at DESC',
    );

    return result.map((e) => TransactionRecordModel.fromJson(e)).toList();
  }

  /// Retrieve all transaction records for a specific transaction type
  static Future<List<TransactionRecordModel>> getTransactionRecordsByTransactionType(int transactionTypeId) async {
    final db = await _dbHelper.database;

    final result = await db.query(
      DatabaseTable.transactionRecord,
      where: 'transaction_type_id = ?',
      whereArgs: [transactionTypeId],
      orderBy: 'created_at DESC',
    );

    return result.map((e) => TransactionRecordModel.fromJson(e)).toList();
  }

  /// Update a transaction record
  static Future<int> updateTransactionRecord({
    required int id,
    int? categoryId,
    int? transactionTypeId,
    String? transactionTypeName,
    String? name,
    double? amount,
    String? description,
    String? createdAt,
  }) async {
    final db = await _dbHelper.database;

    final data = {
      if (categoryId != null) 'category_id': categoryId,
      if (transactionTypeId != null) 'transaction_type_id': transactionTypeId,
      if (transactionTypeName != null) 'transaction_type_name': transactionTypeName,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
    };

    return await db.update(
      DatabaseTable.transactionRecord,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Delete a transaction record
  static Future<int> deleteTransactionRecord(int id) async {
    final db = await _dbHelper.database;

    return await db.delete(
      DatabaseTable.transactionRecord,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Retrieve transaction record details with full information (category and transaction type)
  static Future<Map<String, dynamic>?> getTransactionRecordDetailsById(int id) async {
    final db = await _dbHelper.database;

    final result = await db.rawQuery('''
      SELECT tr.*, c.name AS category_name, t.name AS transaction_type_name
      FROM ${DatabaseTable.transactionRecord} tr
      INNER JOIN ${DatabaseTable.category} c ON tr.category_id = c.id
      INNER JOIN ${DatabaseTable.transactionType} t ON tr.transaction_type_id = t.id
      WHERE tr.id = ?
    ''', [id]);

    return result.isNotEmpty ? result.first : null;
  }
}
