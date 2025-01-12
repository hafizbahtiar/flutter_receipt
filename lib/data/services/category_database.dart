import 'package:intl/intl.dart';
import '../config/database_helper.dart';
import '../config/database_table.dart';
import '../models/category_model.dart';

class CategoryDatabase {
  static final _dbHelper = DatabaseHelper();

  /// Create a new category
  static Future<int> createCategory({
    required String name,
    required int transactionTypeId,
    String? transactionTypeName,
    int parentId = 0,
    String? createdAt,
  }) async {
    final db = await _dbHelper.database;

    final data = {
      'name': name,
      'transaction_type_id': transactionTypeId,
      'transaction_type_name': transactionTypeName,
      'parent_id': parentId,
      'created_at': createdAt ?? DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
    };

    return await db.insert(DatabaseTable.category, data);
  }

  /// Retrieve all categories for a specific transaction type
  static Future<List<CategoryModel>> getAllCategoriesByType(int transactionTypeId) async {
    final db = await _dbHelper.database;

    final result = await db.query(
      DatabaseTable.category,
      where: 'transaction_type_id = ?',
      whereArgs: [transactionTypeId],
      orderBy: 'created_at DESC',
    );

    // Convert each row in the result to a CategoryModel object
    return result.map((json) => CategoryModel.fromJson(json)).toList();
  }

  /// Retrieve all categories
  static Future<List<CategoryModel>> getAllCategories() async {
    final db = await _dbHelper.database;

    final result = await db.query(
      DatabaseTable.category,
      orderBy: 'created_at DESC',
    );

    // Convert each row in the result to a CategoryModel object
    return result.map((json) => CategoryModel.fromJson(json)).toList();
  }

  /// Retrieve a specific category by ID
  static Future<CategoryModel?> getCategoryById(int id) async {
    final db = await _dbHelper.database;

    final result = await db.query(
      DatabaseTable.category,
      where: 'id = ?',
      whereArgs: [id],
    );

    return result.isNotEmpty ? CategoryModel.fromJson(result.first) : null;
  }

  /// Update a category and return the number of affected rows
  static Future<int> updateCategory({
    required int id,
    String? name,
    int? parentId,
    int? transactionTypeId,
    String? createdAt,
  }) async {
    final db = await _dbHelper.database;

    final data = {
      if (name != null) 'name': name,
      if (parentId != null) 'parent_id': parentId,
      if (transactionTypeId != null) 'transaction_type_id': transactionTypeId,
      if (createdAt != null) 'created_at': createdAt,
    };

    return await db.update(
      DatabaseTable.category,
      data,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Delete a category and return the number of affected rows
  static Future<int> deleteCategory(int id) async {
    final db = await _dbHelper.database;

    return await db.delete(
      DatabaseTable.category,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Retrieve subcategories for a specific parent category
  static Future<List<CategoryModel>> getSubcategories(int parentId) async {
    final db = await _dbHelper.database;

    final result = await db.query(
      DatabaseTable.category,
      where: 'parent_id = ?',
      whereArgs: [parentId],
      orderBy: 'created_at DESC',
    );

    return result.map((json) => CategoryModel.fromJson(json)).toList();
  }

  /// Retrieve all categories by transaction type name using a join query
  static Future<List<CategoryModel>> getAllCategoriesByTransactionTypeName(String transactionTypeName) async {
    final db = await _dbHelper.database;

    final result = await db.rawQuery('''
      SELECT c.* 
      FROM ${DatabaseTable.category} c
      INNER JOIN ${DatabaseTable.transactionType} t
      ON c.transaction_type_id = t.id
      WHERE t.name = ?
      ORDER BY c.created_at DESC
    ''', [transactionTypeName]);

    // Convert each row in the result to a CategoryModel object
    return result.map((json) => CategoryModel.fromJson(json)).toList();
  }
}
