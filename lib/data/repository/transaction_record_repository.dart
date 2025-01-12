import 'package:flutter_receipt/data/models/transaction_record_model.dart';
import 'package:flutter_receipt/data/services/transaction_record_database.dart';

class TransactionRecordRepository {
  Future<int> createTransactionRecord({
    required String name,
    required double amount,
    required int categoryId,
    required int transactionTypeId,
    String? transactionTypeName,
    int parentId = 0,
    String? createdAt,
  }) async {
    return await TransactionRecordDatabase.createTransactionRecord(
      name: name,
      transactionTypeId: transactionTypeId,
      transactionTypeName: transactionTypeName!,
      createdAt: createdAt,
      categoryId: categoryId,
      amount: amount,
    );
  }

  Future<List<TransactionRecordModel>> getAllTransactionRecords() async {
    return await TransactionRecordDatabase.getAllTransactionRecords();
  }

  Future<TransactionRecordModel?> getTransactionRecordById(int id) async {
    return await TransactionRecordDatabase.getTransactionRecordById(id);
  }

  Future<List<TransactionRecordModel>> getTransactionRecordsByCategory(int categoryId) async {
    return await TransactionRecordDatabase.getTransactionRecordsByCategory(categoryId);
  }

  Future<List<TransactionRecordModel>> getTransactionRecordsByTransactionType(int transactionTypeId) async {
    return await TransactionRecordDatabase.getTransactionRecordsByTransactionType(transactionTypeId);
  }

  Future<int> updateTransactionRecord({
    required int id,
    String? name,
    int? parentId,
    double? amount,
    String? createdAt,
  }) async {
    return await TransactionRecordDatabase.updateTransactionRecord(
      id: id,
      amount: amount,
      createdAt: createdAt,
    );
  }

  Future<int> deleteTransactionRecord(int id) async {
    return await TransactionRecordDatabase.deleteTransactionRecord(id);
  }

  /// Retrieve subcategories for a specific parent category
  Future<Map<String, dynamic>?> getTransactionRecordDetailsById(int id) async {
    return await TransactionRecordDatabase.getTransactionRecordDetailsById(id);
  }
}
