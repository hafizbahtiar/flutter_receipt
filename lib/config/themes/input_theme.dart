// Define color scheme for dark mode
import 'package:flutter/material.dart';
import 'package:flutter_receipt/config/themes/app_pallete.dart';

InputDecorationTheme inputDecoTheme(bool isDarkMode) {
  return InputDecorationTheme(
    labelStyle: _labelTextStyle(isDarkMode),
    hintStyle: _hintTextStyle(isDarkMode),
    enabledBorder: _outlineEnabledBorder(isDarkMode),
    focusedBorder: _outlineFocusedBorder(isDarkMode),
    errorBorder: _outlineErrorBorder(isDarkMode),
    focusedErrorBorder: _outlineErrorBorder(isDarkMode),
    errorMaxLines: 2,
  );
}

// =====================================================================================
// MARK: - Border Styles
// =====================================================================================

OutlineInputBorder _outlineEnabledBorder(bool isDarkMode) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: isDarkMode ? AppPallete.onBackgroundDark : AppPallete.onBackgroundLight,
      width: 1.0,
    ),
    borderRadius: _borderRadius(),
  );
}

OutlineInputBorder _outlineFocusedBorder(bool isDarkMode) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: isDarkMode ? AppPallete.onBackgroundDark : AppPallete.onBackgroundLight,
      width: 1.0,
    ),
    borderRadius: _borderRadius(),
  );
}

OutlineInputBorder _outlineErrorBorder(bool isDarkMode) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: isDarkMode ? AppPallete.errorDark : AppPallete.errorLight,
      width: 1.0,
    ),
    borderRadius: _borderRadius(),
  );
}

BorderRadius _borderRadius() {
  return const BorderRadius.all(Radius.circular(5.0));
}

// =====================================================================================
// MARK: - Text Styles
// =====================================================================================

TextStyle _labelTextStyle(bool isDarkMode) {
  return TextStyle(
    color: isDarkMode ? AppPallete.onBackgroundDark : AppPallete.onBackgroundLight,
    fontWeight: FontWeight.bold,
  );
}

TextStyle _hintTextStyle(bool isDarkMode) {
  return TextStyle(
    color: isDarkMode ? AppPallete.onBackgroundDark : AppPallete.onBackgroundLight,
  );
}
