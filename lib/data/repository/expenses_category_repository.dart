import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../services/expenses_category_databse.dart';

class ExpensesCategoryRepository {
  /// Fetch all expense categories as a list of `Category` objects
  Future<List<CategoryModel>> getAllExpensesCategories() async {
    try {
      // Fetch the categories from the database
      final categories = await ExpensesCategoryDatabase.getAllExpensesCategories();
      return categories;
    } catch (e) {
      debugPrint("Error fetching expense categories: $e");
      return [];
    }
  }

  /// Add a new expense category
  Future<bool> addExpensesCategory(CategoryModel category) async {
    try {
      final result = await ExpensesCategoryDatabase.createExpensesCategory(
        name: category.name,
        parentId: category.parentId!,
        createdAt: category.createdAt,
      );
      return result > 0;
    } catch (e) {
      debugPrint("Error adding expense category: $e");
      return false;
    }
  }

  /// Update an expense category
  Future<bool> updateExpensesCategory(CategoryModel category) async {
    try {
      final result = await ExpensesCategoryDatabase.updateExpensesCategory(
        id: category.id!,
        name: category.name,
        parentId: category.parentId,
        createdAt: category.createdAt,
      );
      return result > 0;
    } catch (e) {
      debugPrint("Error updating expense category: $e");
      return false;
    }
  }

  /// Delete an expense category by ID
  Future<bool> deleteExpensesCategory(int id) async {
    try {
      final result = await ExpensesCategoryDatabase.deleteExpensesCategory(id);
      return result > 0;
    } catch (e) {
      debugPrint("Error deleting expense category: $e");
      return false;
    }
  }

  /// Fetch subcategories of a specific parent category
  Future<List<CategoryModel>> getSubcategories(int parentId) async {
    try {
      final subcategories = await ExpensesCategoryDatabase.getExpensesSubcategories(parentId);
      return subcategories;
    } catch (e) {
      debugPrint("Error fetching subcategories: $e");
      return [];
    }
  }
}
