import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sqflite/sqflite.dart';

import 'database_table.dart';

class DatabaseSchema {
  static final int currentVersion = int.parse(dotenv.env['DATABASE_VERSION'] ?? '1');

  /// Create tables and insert default categories
  static Future<void> onCreate(Database db, int version) async {
    try {
      // Create income table
      await db.execute('''
        CREATE TABLE ${DatabaseTable.income} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          category_id INT NOT NULL,
          amount REAL NOT NULL,
          description TEXT,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (category_id) REFERENCES ${DatabaseTable.incomeCategory}(id)
        )
      ''');

      // Create expenses table
      await db.execute('''
        CREATE TABLE ${DatabaseTable.expenses} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          category_id INT NOT NULL,
          amount REAL NOT NULL,
          description TEXT,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (category_id) REFERENCES ${DatabaseTable.expensesCategory}(id)
        )
      ''');

      // Create expenses images table
      await db.execute('''
        CREATE TABLE ${DatabaseTable.expensesImages} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          expenses_id INT NOT NULL,
          image BLOB NOT NULL,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP,
          FOREIGN KEY (expenses_id) REFERENCES ${DatabaseTable.expenses}(id)
        )
      ''');

      // Create income category table
      await db.execute('''
        CREATE TABLE ${DatabaseTable.incomeCategory} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          parent_id INT NOT NULL,
          name TEXT NOT NULL,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP
        )
      ''');

      // Create expenses category table
      await db.execute('''
        CREATE TABLE ${DatabaseTable.expensesCategory} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          parent_id INT NOT NULL,
          name TEXT NOT NULL,
          created_at TEXT DEFAULT CURRENT_TIMESTAMP
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
    try {
      await db.transaction((txn) async {
        // Default income categories
        final incomeCategories = [
          {'parent_id': 0, 'name': 'allowance'},
          {'parent_id': 0, 'name': 'salary'},
          {'parent_id': 0, 'name': 'bonus'},
          {'parent_id': 0, 'name': 'investment'},
        ];

        // Default expenses categories
        final expensesCategories = [
          {'parent_id': 0, 'name': 'food'},
          {'parent_id': 0, 'name': 'utility'},
          {'parent_id': 0, 'name': 'transportation'},
          {'parent_id': 0, 'name': 'entertainment'},
        ];

        for (final category in incomeCategories) {
          await txn.insert(DatabaseTable.incomeCategory, category);
        }
        for (final category in expensesCategories) {
          await txn.insert(DatabaseTable.expensesCategory, category);
        }
      });
    } catch (e) {
      debugPrint("Error inserting default categories: $e");
    }
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
