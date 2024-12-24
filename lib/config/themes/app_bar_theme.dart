import 'package:flutter/material.dart';
import 'package:flutter_receipt/config/themes/app_pallete.dart';

AppBarTheme appBarTheme(bool isDarkMode) {
  return AppBarTheme(
    backgroundColor: isDarkMode ? AppPallete.primaryDark : AppPallete.primaryLight,
  );
}
