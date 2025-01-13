import 'package:flutter_receipt/data/repository/category_repository.dart';
import 'package:flutter_receipt/providers/base_provider.dart';

class DropdownProvider extends BaseProvider {
  final CategoryRepository _categoryRepository = CategoryRepository();

  Map<int, String> _incomeCategoriesMap = {};
  Map<int, String> _expensesCategoriesMap = {};

  // ===============================================================================
  //       MARK: Getter
  // ===============================================================================

  Map<int, String> get incomeCategoriesMap => _incomeCategoriesMap;
  Map<int, String> get expensesCategoriesMap => _expensesCategoriesMap;

  // ===============================================================================
  //       MARK: Function
  // ===============================================================================

  Future<void> fetchCategories() async {
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

    notifyListeners();
  }
}
