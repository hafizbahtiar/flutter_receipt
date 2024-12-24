import 'package:flutter/material.dart';
import 'package:flutter_receipt/config/themes/app_bar_theme.dart';
import 'package:flutter_receipt/config/themes/button_theme.dart';
import 'package:flutter_receipt/config/themes/color_theme.dart';
import 'package:flutter_receipt/config/themes/input_theme.dart';
import 'package:flutter_receipt/config/themes/tile_theme.dart';

ThemeData appThemeData(BuildContext context, bool isDarkMode) {
  // Define color scheme based on mode
  final colorScheme = isDarkMode ? darkColorScheme() : lightColorScheme();

  // Create and return the ThemeData based on the current mode
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    inputDecorationTheme: inputDecoTheme(isDarkMode),
    iconButtonTheme: iconButtonTheme(isDarkMode),
    listTileTheme: listTileTheme(isDarkMode),
    elevatedButtonTheme: elevatedButtonTheme(isDarkMode),
    filledButtonTheme: filledButtonTheme(isDarkMode),
    outlinedButtonTheme: outlinedButtonTheme(isDarkMode),
    textButtonTheme: textButtonTheme(isDarkMode),
    appBarTheme: appBarTheme(isDarkMode),
  );
}
