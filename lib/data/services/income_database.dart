import '../config/database_helper.dart';
import '../config/database_table.dart';

class IncomeDatabase {
  static final _dbHelper = DatabaseHelper();

  /// Create a new income record
  static Future<int> createIncome({
    required int categoryId,
    required double amount,
    String? description,
    String? createdAt,
  }) async {
    final db = await _dbHelper.database;

    final data = {
      'category_id': categoryId,
      'amount': amount,
      'description': description,
      'created_at': createdAt ?? DateTime.now().toIso8601String(),
    };

    return await db.insert(DatabaseTable.income, data);
  }

  /// Retrieve all income records with their categories
  static Future<List<Map<String, dynamic>>> getAllIncome() async {
    final db = await _dbHelper.database;

    final result = await db.rawQuery('''
      SELECT i.*, c.name AS category_name
      FROM ${DatabaseTable.income} i
      INNER JOIN ${DatabaseTable.incomeCategory} c ON i.category_id = c.id
      ORDER BY i.created_at DESC
    ''');
    return result;
  }

  /// Retrieve income records by ID
  static Future<Map<String, dynamic>?> getIncomeById(int id) async {
    final db = await _dbHelper.database;

    final result = await db.rawQuery('''
      SELECT i.*, c.name AS category_name
      FROM ${DatabaseTable.income} i
      INNER JOIN ${DatabaseTable.incomeCategory} c ON i.category_id = c.id
      WHERE i.id = ?
    ''', [id]);

    return result.isNotEmpty ? result.first : null;
  }

  /// Update an existing income record
  static Future<int> updateIncome({
    required int id,
    int? categoryId,
    double? amount,
    String? description,
    String? createdAt,
  }) async {
    final db = await _dbHelper.database;

    final data = {
      if (categoryId != null) 'category_id': categoryId,
      if (amount != null) 'amount': amount,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
    };

    return await db.update(
      DatabaseTable.income,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Delete an income record
  static Future<int> deleteIncome(int id) async {
    final db = await _dbHelper.database;

    return await db.delete(
      DatabaseTable.income,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Retrieve total income amount
  static Future<double> getTotalIncome() async {
    final db = await _dbHelper.database;

    final result = await db.rawQuery('''
      SELECT SUM(amount) as total
      FROM ${DatabaseTable.income}
    ''');
    return result.first['total'] != null ? result.first['total'] as double : 0.0;
  }

  /// Retrieve total income amount grouped by category
  static Future<List<Map<String, dynamic>>> getTotalIncomeByCategory() async {
    final db = await _dbHelper.database;

    final result = await db.rawQuery('''
      SELECT c.name AS category_name, SUM(i.amount) AS total
      FROM ${DatabaseTable.income} i
      INNER JOIN ${DatabaseTable.incomeCategory} c ON i.category_id = c.id
      GROUP BY i.category_id
      ORDER BY total DESC
    ''');
    return result;
  }

  /// Retrieve the latest income record with its category
  static Future<Map<String, dynamic>?> getLatestIncome() async {
    final db = await _dbHelper.database;

    final result = await db.rawQuery('''
      SELECT i.*, c.name AS category_name
      FROM ${DatabaseTable.income} i
      INNER JOIN ${DatabaseTable.incomeCategory} c ON i.category_id = c.id
      ORDER BY i.created_at DESC
      LIMIT 1
    ''');

    return result.isNotEmpty ? result.first : null;
  }

  /// Retrieve income records by category
  static Future<List<Map<String, dynamic>>> getIncomeByCategory(int categoryId) async {
    final db = await _dbHelper.database;

    return await db.query(
      DatabaseTable.income,
      where: 'category_id = ?',
      whereArgs: [categoryId],
      orderBy: 'created_at DESC',
    );
  }
}
