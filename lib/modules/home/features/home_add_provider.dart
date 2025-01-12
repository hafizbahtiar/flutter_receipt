import 'package:flutter/material.dart';
import 'package:flutter_receipt/data/models/category_model.dart';
import 'package:flutter_receipt/data/models/income_model.dart';
import 'package:flutter_receipt/data/models/transaction_type_model.dart';
import 'package:flutter_receipt/data/repository/category_repository.dart';
import 'package:flutter_receipt/data/repository/income_repository.dart';
import 'package:flutter_receipt/data/repository/transaction_record_repository.dart';
import 'package:flutter_receipt/data/repository/transaction_type_repository.dart';
import 'package:intl/intl.dart';

class HomeAddProvider with ChangeNotifier {
  final IncomeRepository _repository = IncomeRepository();
  final CategoryRepository _categoryRepository = CategoryRepository();
  final TransactionTypeRepository _transactionTypeRepository = TransactionTypeRepository();
  final TransactionRecordRepository _transactionRecordRepository = TransactionRecordRepository();

  String _date = '';
  double _amount = 0.0;
  String _selectedIncomeCategoryId = '';
  String _selectedExpensesCategoryId = '';
  bool _isLoading = false;
  int _selectedIndex = 0;
  List<TransactionTypeModel>? _transactionType;
  List<CategoryModel> _incomeCategories = [];
  List<CategoryModel> _expensesCategories = [];
  Map<int, String> _transactionTypeMap = {};
  Map<int, String> _incomeCategoriesMap = {};
  Map<int, String> _expensesCategoriesMap = {};

  String get date => _date;
  double get amount => _amount;
  int get selectedIndex => _selectedIndex;
  String get selectedIncomeCategoryId => _selectedIncomeCategoryId;
  String get selectedExpensesCategoryId => _selectedExpensesCategoryId;
  bool get isLoading => _isLoading;
  List<TransactionTypeModel>? get transactionType => _transactionType;
  Map<int, String> get transactionTypeMap => _transactionTypeMap;
  List<CategoryModel> get incomeCategories => _incomeCategories;
  Map<int, String> get incomeCategoriesMap => _incomeCategoriesMap;
  List<CategoryModel> get expensesCategories => _expensesCategories;
  Map<int, String> get expensesCategoriesMap => _expensesCategoriesMap;

  void setDate(String value) {
    if (_date != value) {
      _date = value;
      notifyListeners();
    }
  }

  void setSelectedIndex(int value) {
    if (_selectedIndex != value) {
      _selectedIndex = value;

      notifyListeners();
    }
  }

  void setAmount(double value) {
    if (_amount != value) {
      _amount = value;
      notifyListeners();
    }
  }

  void setSelectedIncomeCategoryId(String value) {
    if (_selectedIncomeCategoryId != value) {
      _selectedIncomeCategoryId = value;
      notifyListeners();
    }
  }

  void setSelectedExpensesCategoryId(String value) {
    if (_selectedExpensesCategoryId != value) {
      _selectedExpensesCategoryId = value;
      notifyListeners();
    }
  }

  void setLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }

  // Initialize the provider by setting default values
  Future<void> init() async {
    setLoading(true);
    _date = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    await fetchCategories();
    await fetchAllTransactionType();
    setLoading(false);
  }

  Future<void> fetchAllTransactionType() async {
    _transactionType = await _transactionTypeRepository.getAllTransactionTypes();

    if (_transactionType != null) {
      _transactionTypeMap = {
        for (var transaction in _transactionType!) transaction.id: transaction.name,
      };

      if (_transactionType!.isNotEmpty) {
        setSelectedIndex(_transactionType!.first.id);
      }
    }
    notifyListeners();
  }

  // Fetch all income categories
  Future<void> fetchCategories() async {
    setLoading(true);
    final incomeCategories = await _categoryRepository.getAllCategoriesByTransactionTypeName('income');
    final expensesCategories = await _categoryRepository.getAllCategoriesByTransactionTypeName('expenses');

    _incomeCategories = incomeCategories;
    _expensesCategories = expensesCategories;

    _incomeCategoriesMap = {
      for (var category in incomeCategories)
        if (category.id != null) category.id!: category.name,
    };

    _expensesCategoriesMap = {
      for (var category in expensesCategories)
        if (category.id != null) category.id!: category.name,
    };

    // Set the first category as selected if available
    if (incomeCategories.isNotEmpty) setSelectedIncomeCategoryId(incomeCategories.first.id!.toString());
    if (expensesCategories.isNotEmpty) setSelectedExpensesCategoryId(expensesCategories.first.id!.toString());

    setLoading(false);
  }

  // Add an existing income record
  Future<bool> addIncome() async {
    setLoading(true);

    // Check if the selectedCategoryId is valid and can be parsed to an integer
    if (_transactionTypeMap[_selectedIndex] == 'income' &&
        (_selectedIncomeCategoryId.isEmpty || _selectedIncomeCategoryId == '')) {
      setLoading(false);
      return false;
    }

    if (_transactionTypeMap[_selectedIndex] == 'expenses' &&
        (_selectedExpensesCategoryId.isEmpty || _selectedExpensesCategoryId == '')) {
      setLoading(false);
      return false;
    }

    print('Category Id Name (income): ${_incomeCategoriesMap[int.parse(_selectedIncomeCategoryId)]}');
    print('Category Id Name (expenses): ${_expensesCategoriesMap[int.parse(_selectedExpensesCategoryId)]}');

    // final income = IncomeModel(
    //   categoryId: int.parse(selectedCategoryId),
    //   amount: amount,
    //   createdAt: _date,
    // );

    // final success = await _transactionRecordRepository.createTransactionRecord(
    //   name: name,
    //   amount: amount,
    //   categoryId: categoryId,
    //   transactionTypeId: transactionTypeId,
    // );
    // setLoading(false);
    // return success;

    return false;
  }

  // Update an existing income record
  Future<bool> updateIncome(IncomeModel income) async {
    setLoading(true);
    final success = await _repository.updateIncome(income);
    setLoading(false);
    return success;
  }

  // Delete an income record
  Future<bool> deleteIncome(int id) async {
    setLoading(true);
    final success = await _repository.deleteIncome(id);
    setLoading(false);
    return success;
  }
}
