import 'package:flutter/material.dart';
import 'package:flutter_receipt/data/models/category_model.dart';
import 'package:flutter_receipt/data/models/income_model.dart';
import 'package:flutter_receipt/data/repository/income_category_repository.dart';
import 'package:flutter_receipt/data/repository/income_repository.dart';
import 'package:intl/intl.dart';

class HomeAddProvider with ChangeNotifier {
  final IncomeRepository _repository = IncomeRepository();
  final IncomeCategoryRepository _repositoryCategory = IncomeCategoryRepository();

  String _date = '';
  double _amount = 0.0;
  String _selectedCategoryId = '';
  bool _isLoading = false;
  List<CategoryModel> _incomeCategories = [];
  Map<int, String> _incomeCategoriesMap = {};

  String get date => _date;
  double get amount => _amount;
  String get selectedCategoryId => _selectedCategoryId;
  bool get isLoading => _isLoading;
  List<CategoryModel> get incomeCategories => _incomeCategories;
  Map<int, String> get incomeCategoriesMap => _incomeCategoriesMap;

  void setDate(String value) {
    if (_date != value) {
      _date = value;
      notifyListeners();
    }
  }

  void setAmount(double value) {
    if (_amount != value) {
      _amount = value;
      notifyListeners();
    }
  }

  void setSelectedCategoryId(String value) {
    if (_selectedCategoryId != value) {
      _selectedCategoryId = value;
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
    setLoading(false);
  }

  // Fetch all income categories
  Future<void> fetchCategories() async {
    setLoading(true);
    final categories = await _repositoryCategory.getAllIncomeCategories();
    _incomeCategories = categories;

    // Create the map from category id to name
    _incomeCategoriesMap = {
      for (var category in categories)
        if (category.id != null) category.id!: category.name,
    };

    // Set the first category as selected if available
    if (categories.isNotEmpty) setSelectedCategoryId(categories.first.id!.toString());

    setLoading(false);
  }

  // Add an existing income record
  Future<bool> addIncome() async {
    setLoading(true);

    // Check if the selectedCategoryId is valid and can be parsed to an integer
    if (selectedCategoryId.isEmpty) {
      setLoading(false);
      return false;
    }

    final income = IncomeModel(
      categoryId: int.parse(selectedCategoryId),
      amount: amount,
      createdAt: _date,
    );

    final success = await _repository.addIncome(income);
    setLoading(false);
    return success;
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
