import 'package:flutter/material.dart';
import 'package:flutter_receipt/data/models/category_model.dart';
import 'package:flutter_receipt/data/repository/expenses_category_repository.dart';
import 'package:intl/intl.dart';

class SettingExpensesCategoryProvider with ChangeNotifier {
  final ExpensesCategoryRepository _repository = ExpensesCategoryRepository();

  List<CategoryModel> _incomeCategories = [];
  bool _isLoading = false;
  int? selectedParentCategory;
  String _categoryName = '';
  List<CategoryModel> parentCategories = [];

  List<CategoryModel> get incomeCategories => _incomeCategories;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    setLoading(true);
    await fetchExpensesCategories();
    setLoading(false);
  }

  Future<void> fetchExpensesCategories() async {
    _incomeCategories = await _repository.getAllExpensesCategories();
    notifyListeners();
  }

  Future<bool> addExpensesCategory() async {
    if (_categoryName.isEmpty) {
      // Validation: Category name should not be empty
      return false;
    }

    setLoading(true);

    // Ensure parentId is not null, if it's null, set it to 0 (or your default value)
    final category = CategoryModel(
      name: _categoryName,
      parentId: selectedParentCategory ?? 0, // Use the default value if null
      createdAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
    );

    try {
      final success = await _repository.addExpensesCategory(category);
      setLoading(false);
      return success;
    } catch (e) {
      debugPrint("Error adding income category: $e");
      setLoading(false);
      return false;
    }
  }

  Future<bool> updateExpensesCategory(CategoryModel category) async {
    category = category.copyWith(name: _categoryName);
    final result = await _repository.updateExpensesCategory(category);
    return result;
  }

  Future<bool> deleteExpensesCategory(int id) async {
    return await _repository.deleteExpensesCategory(id);
  }

  void setLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }

  void setName(String value) {
    if (_categoryName != value) {
      _categoryName = value;
      notifyListeners();
    }
  }
}
