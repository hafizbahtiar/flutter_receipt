import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sqflite/sqflite.dart';

import 'database_table.dart';

class DatabaseSchema {
  static final int currentVersion = int.parse(dotenv.env['DATABASE_VERSION'] ?? '1');

  /// Create tables and insert default categories
  static Future<void> onCreate(Database db, int version) async {
    try {
      // Create transaction type table
      await db.execute('''
        CREATE TABLE ${DatabaseTable.transactionType} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // Create category table
      await db.execute('''
        CREATE TABLE ${DatabaseTable.category} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          parent_id INT NULL,
          transaction_type_id INT NOT NULL,
          transaction_type_name TEXT,
          name TEXT NOT NULL,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (transaction_type_id) REFERENCES ${DatabaseTable.transactionType}(id)
        )
      ''');

      // Create transaction table
      await db.execute('''
        CREATE TABLE ${DatabaseTable.transactionRecord} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          category_id INT NOT NULL,
          transaction_type_id INT NOT NULL,
          transaction_type_name TEXT,
          amount REAL NOT NULL,
          description TEXT,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (category_id) REFERENCES ${DatabaseTable.category}(id),
          FOREIGN KEY (transaction_type_id) REFERENCES ${DatabaseTable.transactionType}(id)
        )
      ''');

      // Create transaction images table
      await db.execute('''
        CREATE TABLE ${DatabaseTable.transactionImages} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          transaction_id INT NOT NULL,
          image BLOB NOT NULL,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (transaction_id) REFERENCES ${DatabaseTable.transactionRecord}(id)
        )
      ''');

      // Insert default categories
      await _insertDefaultCategories(db);
    } catch (e) {
      debugPrint("Error during database creation: $e");
    }
  }

  /// Insert default categories into the database
  static Future<void> _insertDefaultCategories(Database db) async {
    // Insert transaction types and get their IDs
    final incomeTypeId = await db.insert(DatabaseTable.transactionType, {
      'name': 'income',
    });
    final expensesTypeId = await db.insert(DatabaseTable.transactionType, {
      'name': 'expenses',
    });

    // Define categories for income and expenses
    final incomeCategories = ['allowance', 'salary', 'bonus', 'investment', 'freelance', 'rental income'];
    final expensesCategories = ['food', 'utility', 'transportation', 'entertainment', 'healthcare', 'education'];

    // Insert income categories
    for (final category in incomeCategories) {
      await db.insert(DatabaseTable.category, {
        'transaction_type_id': incomeTypeId,
        'name': category,
      });
    }

    // Insert expenses categories
    for (final category in expensesCategories) {
      await db.insert(DatabaseTable.category, {
        'transaction_type_id': expensesTypeId,
        'name': category,
      });
    }

    debugPrint('Transaction types and categories initialized successfully.');
  }

  /// Handles schema upgrades for version changes
  static Future<void> onUpgrade(Database db, int oldVersion, int newVersion) async {
    try {
      if (oldVersion < 2) {
        // Example: Add a column to track timestamps in incomeCategory
        await db.execute('''
          ALTER TABLE ${DatabaseTable.incomeCategory} ADD COLUMN created_at TEXT DEFAULT CURRENT_TIMESTAMP
        ''');
      }

      if (oldVersion < 3) {
        // Example: Add a description column to incomeCategory
        await db.execute('''
          ALTER TABLE ${DatabaseTable.incomeCategory} ADD COLUMN description TEXT
        ''');
      }

      // Add more schema upgrades here for future versions
    } catch (e) {
      debugPrint("Error during schema upgrade: $e");
    }
  }
}
