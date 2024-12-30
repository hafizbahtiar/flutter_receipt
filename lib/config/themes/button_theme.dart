// Define color scheme for dark mode
import 'package:flutter/material.dart';
import 'package:flutter_receipt/config/themes/app_pallete.dart';

IconButtonThemeData iconButtonTheme(bool isDarkMode) {
  return IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStateProperty.all(
        isDarkMode ? AppPallete.onBackgroundDark : AppPallete.onBackgroundLight,
      ),
    ),
  );
}

ElevatedButtonThemeData elevatedButtonTheme(bool isDarkMode) {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all(_textStyle(isDarkMode)),
      minimumSize: WidgetStateProperty.all(const Size(20.0, 50.0)),
      shape: WidgetStateProperty.all(_roundedRectangleBorder()),
    ),
  );
}

OutlinedButtonThemeData outlinedButtonTheme(bool isDarkMode) {
  return OutlinedButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all(_textStyle(isDarkMode)),
      backgroundColor: WidgetStateProperty.all(isDarkMode ? AppPallete.onBackgroundDark : AppPallete.onBackgroundLight),
      foregroundColor: WidgetStateProperty.all(isDarkMode ? AppPallete.primaryDark : AppPallete.primaryLight),
      minimumSize: WidgetStateProperty.all(const Size(20.0, 50.0)),
      shape: WidgetStateProperty.all(_roundedRectangleBorder()),
      side: WidgetStateProperty.all(
        BorderSide(
          width: 1.0,
          color: isDarkMode ? AppPallete.primaryDark : AppPallete.primaryLight,
        ),
      ),
    ),
  );
}

FilledButtonThemeData filledButtonTheme(bool isDarkMode) {
  return FilledButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all(_textStyle(isDarkMode)),
      backgroundColor: WidgetStateProperty.all(isDarkMode ? AppPallete.primaryDark : AppPallete.primaryLight),
      foregroundColor: WidgetStateProperty.all(isDarkMode ? AppPallete.onBackgroundDark : AppPallete.onBackgroundLight),
      minimumSize: WidgetStateProperty.all(const Size(20.0, 50.0)),
      shape: WidgetStateProperty.all(_roundedRectangleBorder()),
    ),
  );
}

TextButtonThemeData textButtonTheme(bool isDarkMode) {
  return TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: isDarkMode ? AppPallete.primaryDark : AppPallete.primaryLight,
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: isDarkMode ? AppPallete.onBackgroundDark : AppPallete.onBackgroundLight,
        decoration: TextDecoration.none,
      ),
      padding: _edgeInsets(),
    ),
  );
}

// =====================================================================================
// MARK: - Private
// =====================================================================================

RoundedRectangleBorder _roundedRectangleBorder() {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
    side: const BorderSide(width: 1.0, color: Colors.transparent),
  );
}

TextStyle _textStyle(bool isDarkMode) {
  return TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold
  );
}

EdgeInsets _edgeInsets() {
  return const EdgeInsets.symmetric(
    vertical: 12.0,
    horizontal: 16.0,
  );
}
