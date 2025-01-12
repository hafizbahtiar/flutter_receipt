import 'package:flutter_receipt/data/config/database_helper.dart';
import 'package:flutter_receipt/data/models/income_model.dart';
import 'package:flutter_receipt/data/config/database_table.dart';

class IncomeRepository {
  final _dbHelper = DatabaseHelper();

  // Create a new income record
  Future<bool> addIncome(IncomeModel income) async {
    final db = await _dbHelper.database;

    final result = await db.insert(
      DatabaseTable.income,
      {
        'category_id': income.categoryId,
        'amount': income.amount,
        'description': income.description,
        'created_at': income.createdAt ?? DateTime.now().toIso8601String(),
      },
    );
    return result > 0; // Return true if insert was successful
  }

  // Fetch all income records
  Future<List<IncomeModel>> getAllIncomes() async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> data = await db.query(
      DatabaseTable.income,
      orderBy: 'created_at DESC',
    );

    return data.map((json) => IncomeModel.fromJson(json)).toList();
  }

  // Fetch a specific income record by ID
  Future<IncomeModel?> getIncomeById(int id) async {
    final db = await _dbHelper.database;

    final result = await db.query(
      DatabaseTable.income,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return IncomeModel.fromJson(result.first);
    }
    return null;
  }

  // Update an existing income record
  Future<bool> updateIncome(IncomeModel income) async {
    final db = await _dbHelper.database;

    final result = await db.update(
      DatabaseTable.income,
      {
        'category_id': income.categoryId,
        'amount': income.amount,
        'description': income.description,
        'created_at': income.createdAt,
      },
      where: 'id = ?',
      whereArgs: [income.id],
    );

    return result > 0; // Return true if the update was successful
  }

  // Delete an income record
  Future<bool> deleteIncome(int id) async {
    final db = await _dbHelper.database;

    final result = await db.delete(
      DatabaseTable.income,
      where: 'id = ?',
      whereArgs: [id],
    );

    return result > 0; // Return true if the delete was successful
  }
}
