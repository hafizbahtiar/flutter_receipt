import '../models/category_model.dart';
import '../services/income_category_database.dart';

class IncomeCategoryRepository {
  /// Fetch all income categories as a list of `Category` objects
  Future<List<CategoryModel>> getAllIncomeCategories() async {
    return await IncomeCategoryDatabase.getAllIncomeCategories();
  }

  /// Add a new income category
  Future<bool> addIncomeCategory(CategoryModel category) async {
    // Ensure that parentId is always set, even if it is null in the model
    final parentId = category.parentId ?? 0; // Set default if null

    final result = await IncomeCategoryDatabase.createIncomeCategory(
      name: category.name,
      parentId: parentId, // Safely handle the parentId here
      createdAt: category.createdAt,
    );
    // Return true if the category was added successfully
    return result > 0;
  }

  /// Update an existing income category
  Future<bool> updateIncomeCategory(CategoryModel category) async {
    if (category.id == null) return false;

    // Ensure that parentId is always set, even if it is null in the model
    final parentId = category.parentId ?? 0; // Set default if null

    // Call the database method to update the category
    final result = await IncomeCategoryDatabase.updateIncomeCategory(
      id: category.id!,
      name: category.name,
      parentId: parentId, // Safely handle the parentId here
      createdAt: category.createdAt,
    );

    // Return true if the category was updated successfully
    return result > 0;
  }

  /// Delete an income category by its ID
  Future<bool> deleteIncomeCategory(int id) async {
    final result = await IncomeCategoryDatabase.deleteIncomeCategory(id);
    // Return true if the category was deleted successfully
    return result > 0;
  }
}
