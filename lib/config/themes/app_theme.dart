import 'package:flutter/material.dart';
import 'package:flutter_receipt/config/themes/appbar_theme.dart';
import 'package:flutter_receipt/config/themes/button_theme.dart';
import 'package:flutter_receipt/config/themes/color_theme.dart';
import 'package:flutter_receipt/config/themes/input_theme.dart';

ThemeData appThemeData(BuildContext context,bool isDarkMode) {

  return ThemeData(
    useMaterial3: true,
    primaryColor: LightColorScheme().primary,
    primaryColorLight: LightColorScheme().primary,
    primaryColorDark: DarkColorScheme().primary,
    colorScheme: colorSchema(isDarkMode),
    appBarTheme: appBarTheme(context),
    inputDecorationTheme: inputDecoTheme(context),
    elevatedButtonTheme: elevatedButtonTheme(),
    filledButtonTheme: filledButtonTheme(),
    outlinedButtonTheme: outlinedButtonTheme(),
    textButtonTheme: textButtonTheme(),
  );
}
