import '../config/database_helper.dart';
import '../config/database_table.dart';
import '../models/category_model.dart';

class IncomeCategoryDatabase {
  static final _dbHelper = DatabaseHelper();

  /// Create a new income category
  static Future<int> createIncomeCategory({
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

    return await db.insert(DatabaseTable.incomeCategory, data);
  }

  /// Retrieve all income categories as Category objects
  static Future<List<CategoryModel>> getAllIncomeCategories() async {
    final db = await _dbHelper.database;

    final result = await db.query(
      DatabaseTable.incomeCategory,
      orderBy: 'created_at DESC',
    );

    // Convert each row in the result to a Category object
    return result.map((json) => CategoryModel.fromJson(json)).toList();
  }

  /// Retrieve a specific income category by ID as a Category object
  static Future<CategoryModel?> getIncomeCategoryById(int id) async {
    final db = await _dbHelper.database;

    final result = await db.query(
      DatabaseTable.incomeCategory,
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.isNotEmpty ? CategoryModel.fromJson(result.first) : null;
  }

  /// Update an income category and return the number of affected rows
  static Future<int> updateIncomeCategory({
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
      DatabaseTable.incomeCategory,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Delete an income category and return the number of affected rows
  static Future<int> deleteIncomeCategory(int id) async {
    final db = await _dbHelper.database;

    return await db.delete(
      DatabaseTable.incomeCategory,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Retrieve subcategories for a specific parent income category
  static Future<List<CategoryModel>> getIncomeSubcategories(int parentId) async {
    final db = await _dbHelper.database;

    final result = await db.query(
      DatabaseTable.incomeCategory,
      where: 'parent_id = ?',
      whereArgs: [parentId],
      orderBy: 'created_at DESC',
    );

    return result.map((json) => CategoryModel.fromJson(json)).toList();
  }
}
