import 'dart:typed_data';
import '../config/database_helper.dart';
import '../config/database_table.dart';

class ExpensesDatabase {
  static final _dbHelper = DatabaseHelper();

  /// Create a new expense record with optional images
  static Future<int> createExpense({
    required int categoryId,
    required double amount,
    String? description,
    String? createdAt,
    List<Uint8List>? images, // Optional list of images
  }) async {
    final db = await _dbHelper.database;
    int expenseId = 0;

    await db.transaction((txn) async {
      final data = {
        'category_id': categoryId,
        'amount': amount,
        'description': description,
        'created_at': createdAt ?? DateTime.now().toIso8601String(),
      };

      expenseId = await txn.insert(DatabaseTable.expenses, data);

      // Insert images if provided
      if (images != null && images.isNotEmpty) {
        for (var image in images) {
          await txn.insert(DatabaseTable.expensesImages, {
            'expenses_id': expenseId,
            'image': image,
            'created_at': DateTime.now().toIso8601String(),
          });
        }
      }
    });

    return expenseId;
  }

  /// Retrieve all expenses with their categories and images
  static Future<List<Map<String, dynamic>>> getAllExpenses() async {
    final db = await _dbHelper.database;

    final result = await db.rawQuery('''
      SELECT e.*, c.name AS category_name, 
        (SELECT COUNT(*) FROM ${DatabaseTable.expensesImages} ei WHERE ei.expenses_id = e.id) AS image_count
      FROM ${DatabaseTable.expenses} e
      INNER JOIN ${DatabaseTable.expensesCategory} c ON e.category_id = c.id
      ORDER BY e.created_at DESC
    ''');
    return result;
  }

  /// Retrieve a single expense record with its images
  static Future<Map<String, dynamic>?> getExpenseById(int id) async {
    final db = await _dbHelper.database;

    final expense = await db.rawQuery('''
      SELECT e.*, c.name AS category_name
      FROM ${DatabaseTable.expenses} e
      INNER JOIN ${DatabaseTable.expensesCategory} c ON e.category_id = c.id
      WHERE e.id = ?
    ''', [id]);

    if (expense.isEmpty) return null;

    final images = await db.query(
      DatabaseTable.expensesImages,
      where: 'expenses_id = ?',
      whereArgs: [id],
    );

    return {
      ...expense.first,
      'images': images,
    };
  }

  /// Update an expense record and optionally update its images
  static Future<int> updateExpense({
    required int id,
    int? categoryId,
    double? amount,
    String? description,
    String? createdAt,
    List<Uint8List>? images, // Optional list of images for replacement
  }) async {
    final db = await _dbHelper.database;
    int rowsAffected = 0;

    await db.transaction((txn) async {
      final data = {
        if (categoryId != null) 'category_id': categoryId,
        if (amount != null) 'amount': amount,
        if (description != null) 'description': description,
        if (createdAt != null) 'created_at': createdAt,
      };

      if (data.isNotEmpty) {
        rowsAffected = await txn.update(
          DatabaseTable.expenses,
          data,
          where: 'id = ?',
          whereArgs: [id],
        );
      }

      if (images != null) {
        // Delete existing images and insert new ones
        await txn.delete(
          DatabaseTable.expensesImages,
          where: 'expenses_id = ?',
          whereArgs: [id],
        );

        for (var image in images) {
          await txn.insert(DatabaseTable.expensesImages, {
            'expenses_id': id,
            'image': image,
            'created_at': DateTime.now().toIso8601String(),
          });
        }
      }
    });

    return rowsAffected;
  }

  /// Delete an expense and its associated images
  static Future<int> deleteExpense(int id) async {
    final db = await _dbHelper.database;

    return await db.transaction((txn) async {
      await txn.delete(
        DatabaseTable.expensesImages,
        where: 'expenses_id = ?',
        whereArgs: [id],
      );

      return await txn.delete(
        DatabaseTable.expenses,
        where: 'id = ?',
        whereArgs: [id],
      );
    });
  }

  /// Retrieve total expense amount grouped by category
  static Future<List<Map<String, dynamic>>> getTotalExpensesByCategory() async {
    final db = await _dbHelper.database;

    return await db.rawQuery('''
      SELECT c.name AS category_name, SUM(e.amount) AS total
      FROM ${DatabaseTable.expenses} e
      INNER JOIN ${DatabaseTable.expensesCategory} c ON e.category_id = c.id
      GROUP BY e.category_id
      ORDER BY total DESC
    ''');
  }

  /// Retrieve the latest expense record with its category
  static Future<Map<String, dynamic>?> getLatestExpense() async {
    final db = await _dbHelper.database;

    final result = await db.rawQuery('''
      SELECT e.*, c.name AS category_name
      FROM ${DatabaseTable.expenses} e
      INNER JOIN ${DatabaseTable.expensesCategory} c ON e.category_id = c.id
      ORDER BY e.created_at DESC
      LIMIT 1
    ''');

    return result.isNotEmpty ? result.first : null;
  }

  /// Retrieve all images for a specific expense
  static Future<List<Map<String, dynamic>>> getImagesByExpenseId(int expenseId) async {
    final db = await _dbHelper.database;

    return await db.query(
      DatabaseTable.expensesImages,
      where: 'expenses_id = ?',
      whereArgs: [expenseId],
    );
  }
}
