import 'package:flutter_receipt/data/models/category_model.dart';

import '../config/database_helper.dart';
import '../config/database_table.dart';

class ExpensesCategoryDatabase {
  static final _dbHelper = DatabaseHelper();

  /// Create a new expense category
  static Future<int> createExpensesCategory({
    required String name,
    int parentId = 0,
    String? createdAt,
  }) async {
    final db = await _dbHelper.database;

    final data = {
      'name': name,
      'parent_id': parentId,
      'created_at': createdAt ?? DateTime.now().toIso8601String(),
    };

    return await db.insert(DatabaseTable.expensesCategory, data);
  }

  /// Retrieve all expense categories as a list of Category objects
  static Future<List<CategoryModel>> getAllExpensesCategories() async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> result = await db.query(
      DatabaseTable.expensesCategory,
      orderBy: 'created_at DESC',
    );

    // Convert each Map<String, dynamic> to a Category instance
    return result.map<CategoryModel>((json) => CategoryModel.fromJson(json)).toList();
  }

  /// Retrieve a specific expense category by ID
  static Future<CategoryModel?> getExpensesCategoryById(int id) async {
    final db = await _dbHelper.database;

    final result = await db.query(
      DatabaseTable.expensesCategory,
      where: 'id = ?',
      whereArgs: [id],
    );

    // Return a Category object if the result is not empty
    return result.isNotEmpty ? CategoryModel.fromJson(result.first) : null;
  }

  /// Update an expense category
  static Future<int> updateExpensesCategory({
    required int id,
    String? name,
    int? parentId,
    String? createdAt,
  }) async {
    final db = await _dbHelper.database;

    final data = {
      if (name != null) 'name': name,
      if (parentId != null) 'parent_id': parentId,
      if (createdAt != null) 'created_at': createdAt,
    };

    return await db.update(
      DatabaseTable.expensesCategory,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Delete an expense category
  static Future<int> deleteExpensesCategory(int id) async {
    final db = await _dbHelper.database;

    return await db.delete(
      DatabaseTable.expensesCategory,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Retrieve subcategories for a specific parent expense category
  static Future<List<CategoryModel>> getExpensesSubcategories(int parentId) async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> result = await db.query(
      DatabaseTable.expensesCategory,
      where: 'parent_id = ?',
      whereArgs: [parentId],
      orderBy: 'created_at DESC',
    );

    // Convert each Map<String, dynamic> to a Category instance
    return result.map<CategoryModel>((json) => CategoryModel.fromJson(json)).toList();
  }
}
