import 'package:flutter/material.dart';
import 'package:flutter_receipt/core/utils/shared_prefs.dart';

class UserPrefsProvider extends ChangeNotifier {
  final prefs = SharedPrefs().prefs;

  // Default initial settings
  bool _isDarkMode = false;
  String _languageCode = 'ms'; // Default to English

  // Getters
  bool get isDarkMode => _isDarkMode;
  String get languageCode => _languageCode;

  // Initialize provider by loading values from SharedPreferences
  Future<void> initialize() async {
    _isDarkMode = await _getDarkModeFromPrefs();
    _languageCode = await _getLanguageCodeFromPrefs();
    notifyListeners();
  }

  // Setters
  Future<void> setDarkMode(bool value) async {
    if (_isDarkMode != value) {
      _isDarkMode = value;
      await _saveDarkModeToPrefs(value);
      notifyListeners();
    }
  }

  Future<void> setLanguageCode(String value) async {
    if (_languageCode != value) {
      _languageCode = value;
      await _saveLanguageCodeToPrefs(value);
      notifyListeners();
    }
  }

  // SharedPreferences helpers
  Future<void> _saveDarkModeToPrefs(bool value) async {
    await prefs?.setBool(PrefsName.isDarkMode, value);
  }

  Future<bool> _getDarkModeFromPrefs() async {
    return prefs?.getBool(PrefsName.isDarkMode) ?? false;
  }

  Future<void> _saveLanguageCodeToPrefs(String value) async {
    await prefs?.setString(PrefsName.languageCode, value);
  }

  Future<String> _getLanguageCodeFromPrefs() async {
    return prefs?.getString(PrefsName.languageCode) ?? 'ms';
  }
}
