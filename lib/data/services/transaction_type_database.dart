import 'package:intl/intl.dart';

import '../config/database_helper.dart';
import '../config/database_table.dart';

class TransactionTypeDatabase {
  static final _dbHelper = DatabaseHelper();

  /// Create a new transaction type
  static Future<int> createTransactionType({
    required String name,
    String? createdAt,
  }) async {
    final db = await _dbHelper.database;

    final data = {
      'name': name,
      'created_at': createdAt ?? DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
    };

    return await db.insert(DatabaseTable.transactionType, data);
  }

  /// Retrieve all transaction types
  static Future<List<Map<String, dynamic>>> getAllTransactionTypes() async {
    final db = await _dbHelper.database;

    final result = await db.query(
      DatabaseTable.transactionType,
      orderBy: 'created_at DESC',
    );

    return result;
  }

  /// Retrieve a specific transaction type by ID
  static Future<Map<String, dynamic>?> getTransactionTypeById(int id) async {
    final db = await _dbHelper.database;

    final result = await db.query(
      DatabaseTable.transactionType,
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.isNotEmpty ? result.first : null;
  }

  /// Update a transaction type
  static Future<int> updateTransactionType({
    required int id,
    String? name,
    String? createdAt,
  }) async {
    final db = await _dbHelper.database;

    final data = {
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
    };

    return await db.update(
      DatabaseTable.transactionType,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Delete a transaction type
  static Future<int> deleteTransactionType(int id) async {
    final db = await _dbHelper.database;

    return await db.delete(
      DatabaseTable.transactionType,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
