import 'package:flutter/material.dart';
import 'package:flutter_receipt/core/utils/shared_prefs.dart';

class UserPrefsProvider extends ChangeNotifier {
  final prefs = SharedPrefs().prefs;

  // Default initial settings
  ThemeMode _themeMode = ThemeMode.light; // Default to ThemeMode.light
  String _languageCode = 'ms'; // Default to Malay

  // Getters
  ThemeMode get themeMode => _themeMode;
  String get languageCode => _languageCode;

  // Initialize provider by loading values from SharedPreferences
  Future<void> initialize() async {
    _themeMode = await _getThemeModeFromPrefs();
    _languageCode = await _getLanguageCodeFromPrefs();
    notifyListeners();
  }

  // Setters
  Future<void> setThemeMode(ThemeMode value) async {
    if (_themeMode != value) {
      _themeMode = value;
      await _saveThemeModeToPrefs(value);
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

// SharedPreferences helpers for ThemeMode
  Future<void> _saveThemeModeToPrefs(ThemeMode value) async {
    debugPrint('Saving theme mode: $value');
    await prefs?.setString(PrefsName.themeMode, themeModeToString(value)); // Save as String
  }

  Future<ThemeMode> _getThemeModeFromPrefs() async {
    final value = prefs?.getString(PrefsName.themeMode) ?? 'light'; // Default to 'light'
    return stringToThemeMode(value); // Convert string back to ThemeMode
  }

  // Helper function to convert ThemeMode to String
  String themeModeToString(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.light:
        return 'light';
      case ThemeMode.system:
        return 'system';
      default:
        return 'light'; // Default case
    }
  }

  // Helper function to convert String to ThemeMode
  ThemeMode stringToThemeMode(String value) {
    switch (value) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.light; // Default case
    }
  }

  // SharedPreferences helpers for language code
  Future<void> _saveLanguageCodeToPrefs(String value) async {
    await prefs?.setString(PrefsName.languageCode, value);
  }

  Future<String> _getLanguageCodeFromPrefs() async {
    return prefs?.getString(PrefsName.languageCode) ?? 'ms';
  }
}
