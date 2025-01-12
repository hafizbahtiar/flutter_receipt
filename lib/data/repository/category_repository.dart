import 'package:flutter_receipt/data/models/category_model.dart';

import '../services/category_database.dart';

class CategoryRepository {
  /// Create a new category
  Future<int> createCategory({
    required String name,
    required int transactionTypeId,
    String? transactionTypeName,
    int parentId = 0,
    String? createdAt,
  }) async {
    return await CategoryDatabase.createCategory(
      name: name,
      transactionTypeId: transactionTypeId,
      transactionTypeName: transactionTypeName,
      parentId: parentId,
      createdAt: createdAt,
    );
  }

  /// Retrieve all categories for a specific transaction type
  Future<List<CategoryModel>> getAllCategoriesByType(int transactionTypeId) async {
    return await CategoryDatabase.getAllCategoriesByType(transactionTypeId);
  }

  /// Retrieve a specific category by ID
  Future<CategoryModel?> getCategoryById(int id) async {
    return await CategoryDatabase.getCategoryById(id);
  }

  /// Retrieve all categories
  Future<List<CategoryModel>> getAllCategories() async {
    return await CategoryDatabase.getAllCategories();
  }

  /// Update a category and return the number of affected rows
  Future<int> updateCategory({
    required int id,
    String? name,
    int? parentId,
    int? transactionTypeId,
    String? createdAt,
  }) async {
    return await CategoryDatabase.updateCategory(
      id: id,
      name: name,
      parentId: parentId,
      transactionTypeId: transactionTypeId,
      createdAt: createdAt,
    );
  }

  /// Delete a category and return the number of affected rows
  Future<int> deleteCategory(int id) async {
    return await CategoryDatabase.deleteCategory(id);
  }

  /// Retrieve subcategories for a specific parent category
  Future<List<CategoryModel>> getSubcategories(int parentId) async {
    return await CategoryDatabase.getSubcategories(parentId);
  }

  /// Retrieve all categories by transaction type name using a join query
  Future<List<CategoryModel>> getAllCategoriesByTransactionTypeName(String transactionTypeName) async {
    return await CategoryDatabase.getAllCategoriesByTransactionTypeName(transactionTypeName.toLowerCase());
  }
}
