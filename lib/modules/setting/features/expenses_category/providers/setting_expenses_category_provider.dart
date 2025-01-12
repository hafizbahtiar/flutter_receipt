import 'package:flutter/material.dart';
import 'package:flutter_receipt/data/models/category_model.dart';
import 'package:flutter_receipt/data/models/transaction_type_model.dart';
import 'package:flutter_receipt/data/repository/category_repository.dart';
import 'package:flutter_receipt/data/repository/transaction_type_repository.dart';

class SettingExpensesCategoryProvider with ChangeNotifier {
  final CategoryRepository _repository = CategoryRepository();
  final TransactionTypeRepository _transactionRepository = TransactionTypeRepository();

  List<CategoryModel> _expensesCategories = [];
  bool _isLoading = false;
  int? selectedParentCategory;
  TransactionTypeModel? _transactionType;
  String _categoryName = '';

  List<CategoryModel> get expensesCategories => _expensesCategories;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    setLoading(true);
    await fetchExpensesCategories();
    await fetchTransactionType();
    setLoading(false);
  }

  Future<void> fetchExpensesCategories() async {
    _expensesCategories = await _repository.getAllCategoriesByTransactionTypeName('expenses');
    notifyListeners();
  }

  Future<void> fetchTransactionType() async {
    _transactionType = await _transactionRepository.getTransactionTypeByName('expenses');
    notifyListeners();
  }

  Future<bool> addExpensesCategory() async {
    if (_categoryName.isEmpty) return false;
    setLoading(true);
    final categoryId = await _repository.createCategory(
      name: _categoryName,
      transactionTypeId: _transactionType!.id,
      transactionTypeName: _transactionType!.name,
    );
    setLoading(false);
    return categoryId > 0;
  }

  Future<bool> updateExpensesCategory(int id) async {
    final result = await _repository.updateCategory(
      id: id,
      name: _categoryName,
    );
    return result > 0;
  }

  Future<bool> deleteExpensesCategory(int id) async {
    final result = await _repository.deleteCategory(id);
    return result > 0;
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
