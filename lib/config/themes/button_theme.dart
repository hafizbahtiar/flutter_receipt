// Define color scheme for dark mode
import 'package:flutter/material.dart';

ElevatedButtonThemeData elevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      minimumSize: WidgetStateProperty.all(const Size(20.0, 50.0)),
      shape: WidgetStateProperty.all(_roundedRectangleBorder()),
    ),
  );
}

OutlinedButtonThemeData outlinedButtonTheme() {
  return OutlinedButtonThemeData(
    style: ButtonStyle(
      minimumSize: WidgetStateProperty.all(const Size(20.0, 50.0)),
      shape: WidgetStateProperty.all(_roundedRectangleBorder()),
      side: WidgetStateProperty.all(BorderSide(width: 1.0)),
    ),
  );
}

FilledButtonThemeData filledButtonTheme() {
  return FilledButtonThemeData(
    style: ButtonStyle(
      minimumSize: WidgetStateProperty.all(const Size(20.0, 50.0)),
      shape: WidgetStateProperty.all(_roundedRectangleBorder()),
    ),
  );
}

TextButtonThemeData textButtonTheme() {
  return TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, decoration: TextDecoration.none),
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

EdgeInsets _edgeInsets() {
  return const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0);
}
