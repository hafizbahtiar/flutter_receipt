import 'package:flutter/material.dart';
import 'package:flutter_receipt/data/models/category_model.dart';
import 'package:flutter_receipt/data/models/transaction_type_model.dart';
import 'package:flutter_receipt/data/repository/category_repository.dart';
import 'package:flutter_receipt/data/repository/transaction_type_repository.dart';

class SettingIncomeCategoryProvider with ChangeNotifier {
  final CategoryRepository _repository = CategoryRepository();
  final TransactionTypeRepository _transactionRepository = TransactionTypeRepository();

  List<CategoryModel> _incomeCategories = [];
  bool _isLoading = false;
  int? selectedParentCategory;
  TransactionTypeModel? _transactionType;
  String _categoryName = '';
  List<CategoryModel> parentCategories = [];

  List<CategoryModel> get incomeCategories => _incomeCategories;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    setLoading(true);
    await fetchIncomeCategories();
    await fetchTransactionType();
    setLoading(false);
  }

  Future<void> fetchIncomeCategories() async {
    _incomeCategories = await _repository.getAllCategoriesByTransactionTypeName('income');
    notifyListeners();
  }

  Future<void> fetchTransactionType() async {
    _transactionType = await _transactionRepository.getTransactionTypeByName('income');
    notifyListeners();
  }

  Future<bool> addIncomeCategory() async {
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

  Future<bool> updateIncomeCategory(int id) async {
    final result = await _repository.updateCategory(
      id: id,
      name: _categoryName,
    );
    return result > 0;
  }

  Future<bool> deleteIncomeCategory(int id) async {
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
