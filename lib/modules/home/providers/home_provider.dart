import 'package:flutter/material.dart';
import 'package:flutter_receipt/data/models/income_model.dart';
import 'package:flutter_receipt/data/repository/income_category_repository.dart';
import 'package:flutter_receipt/data/repository/income_repository.dart';

class HomeProvider with ChangeNotifier {
  final IncomeRepository _repository = IncomeRepository();
  final IncomeCategoryRepository _repositoryCategory = IncomeCategoryRepository();

  List<IncomeModel> _incomeRecords = [];
  Map<int, String> _incomeCategoriesMap = {};
  bool _isLoading = false;
  String? _errorMessage;

  List<IncomeModel> get incomeRecords => _incomeRecords;
  Map<int, String> get incomeCategoriesMap => _incomeCategoriesMap;
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
    // setLoading(true);
    // await fetchAllIncome();
    // await fetchCategories();
    // setLoading(false);
    // notifyListeners();
  }

  /// Fetch all income records
  Future<void> fetchAllIncome() async {
    setLoading(true);
    try {
      final incomes = await _repository.getAllIncomes();
      _incomeRecords = incomes;
      setErrorMessage(null); // Clear any previous errors
    } catch (e) {
      setErrorMessage('Failed to fetch income records. Please try again.');
      debugPrint('Error fetching income records: $e');
    } finally {
      setLoading(false);
    }
  }

  // Fetch all income categories
  Future<void> fetchCategories() async {
    setLoading(true);
    final categories = await _repositoryCategory.getAllIncomeCategories();
    _incomeCategoriesMap = {
      for (var category in categories)
        if (category.id != null) category.id!: category.name,
    };
    setLoading(false);
  }

  /// Add a new income record and refresh the list
  Future<bool> addIncome(IncomeModel income) async {
    setLoading(true);
    try {
      final success = await _repository.addIncome(income);
      if (success) {
        await fetchAllIncome(); // Refresh income list after addition
      }
      return success;
    } catch (e) {
      setErrorMessage('Error adding income: $e');
      debugPrint('Error adding income: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }

  /// Delete an income record and refresh the list
  Future<bool> deleteIncome(int id) async {
    setLoading(true);
    try {
      final success = await _repository.deleteIncome(id);
      if (success) {
        await fetchAllIncome(); // Refresh income list after deletion
      }
      return success;
    } catch (e) {
      setErrorMessage('Error deleting income: $e');
      debugPrint('Error deleting income: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }

  /// Update an income record and refresh the list
  Future<bool> updateIncome(IncomeModel income) async {
    setLoading(true);
    try {
      final success = await _repository.updateIncome(income);
      if (success) {
        await fetchAllIncome(); // Refresh income list after update
      }
      return success;
    } catch (e) {
      setErrorMessage('Error updating income: $e');
      debugPrint('Error updating income: $e');
      return false;
    } finally {
      setLoading(false);
    }
  }
}
