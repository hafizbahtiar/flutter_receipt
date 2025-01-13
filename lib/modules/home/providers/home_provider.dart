import 'package:flutter/material.dart';
import 'package:flutter_receipt/data/models/transaction_record_model.dart';
import 'package:flutter_receipt/data/repository/category_repository.dart';
import 'package:flutter_receipt/data/repository/transaction_record_repository.dart';

class HomeProvider with ChangeNotifier {
  final CategoryRepository _categoryRepository = CategoryRepository();
  final TransactionRecordRepository _transactionRecordRepository = TransactionRecordRepository();

  List<TransactionRecordModel> _transactionRecords = [];
  Map<int, String> _incomeCategoriesMap = {};
  Map<int, String> _expensesCategoriesMap = {};
  bool _isLoading = false;
  String? _errorMessage;

  List<TransactionRecordModel> get transactionRecords => _transactionRecords;
  Map<int, String> get incomeCategoriesMap => _incomeCategoriesMap;
  Map<int, String> get expensesCategoriesMap => _expensesCategoriesMap;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }

  void setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// Initialize the provider by fetching all income records
  Future<void> init() async {
    setLoading(true);
    await fetchCategories();
    await fetchAllTransactionRecord();
    setLoading(false);
    notifyListeners();
  }

  /// Fetch all income records
  Future<void> fetchAllTransactionRecord() async {
    _transactionRecords = await _transactionRecordRepository.getAllTransactionRecords();
    notifyListeners();
  }

  // Fetch all income categories
  Future<void> fetchCategories() async {
    setLoading(true);
    final incomeCategories = await _categoryRepository.getAllCategoriesByTransactionTypeName('income');
    final expensesCategories = await _categoryRepository.getAllCategoriesByTransactionTypeName('expenses');

    _incomeCategoriesMap = {
      for (var category in incomeCategories)
        if (category.id != null) category.id!: category.name,
    };

    _expensesCategoriesMap = {
      for (var category in expensesCategories)
        if (category.id != null) category.id!: category.name,
    };

    setLoading(false);
  }
}
