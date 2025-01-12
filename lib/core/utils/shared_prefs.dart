import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  // Singleton instance
  static final SharedPrefs _instance = SharedPrefs._internal();

  SharedPreferences? _prefs;

  // Private constructor
  SharedPrefs._internal();

  // Factory constructor for singleton
  factory SharedPrefs() => _instance;

  /// Initialize SharedPreferences
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Reset specific keys in SharedPreferences
  Future<void> resetKeys(List<String> keys) async {
    if (_prefs == null) return;
    for (String key in keys) {
      await _prefs?.remove(key);
    }
  }

  /// Reset all user-specific data in SharedPreferences
  Future<void> resetUserData() async {
    await resetKeys([
      PrefsName.user,
      PrefsName.token,
    ]);
  }

  /// Clear all SharedPreferences
  Future<void> clearAll() async {
    await _prefs?.clear();
  }

  /// Get a value from SharedPreferences by key
  T? getValue<T>(String key) {
    return _prefs?.get(key) as T?;
  }

  /// Set a value in SharedPreferences by key
  Future<bool> setValue<T>(String key, T value) async {
    if (_prefs == null) return false;

    if (value is int) {
      return await _prefs!.setInt(key, value);
    } else if (value is double) {
      return await _prefs!.setDouble(key, value);
    } else if (value is bool) {
      return await _prefs!.setBool(key, value);
    } else if (value is String) {
      return await _prefs!.setString(key, value);
    } else if (value is List<String>) {
      return await _prefs!.setStringList(key, value);
    } else {
      throw UnsupportedError('Unsupported value type: ${value.runtimeType}');
    }
  }

  /// Check if a key exists in SharedPreferences
  bool containsKey(String key) {
    return _prefs?.containsKey(key) ?? false;
  }

  /// Remove a value by key from SharedPreferences
  Future<bool> removeValue(String key) async {
    return await _prefs?.remove(key) ?? false;
  }

  /// Retrieve SharedPreferences instance
  SharedPreferences? get prefs => _prefs;
}

class PrefsName {
  /// The route name for the Site Briefing Interest screen.
  /// This constant is used to identify the SharedPreferences key
  /// related to storing and retrieving user preferences for
  /// the Site Briefing Interest feature. It helps maintain
  /// consistency and avoid hardcoding the route name throughout
  /// the application.
  static const String user = 'user';
  static const String token = 'token';
  static const String themeMode = 'themeMode';
  static const String languageCode = 'languageCode';
  static const String isSubCategory = 'isSubCategory';

  static String states(String countryCode) {
    return '${countryCode}State';
  }

  static String coach(String coach) {
    return '${coach.toLowerCase()}Coach';
  }

  static String firstTime(String page) {
    return '${page.toLowerCase()}FirstTime';
  }
}
