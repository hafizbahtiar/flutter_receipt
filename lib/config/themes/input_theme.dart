// Define color scheme for dark mode
import 'package:flutter/material.dart';

InputDecorationTheme inputDecoTheme(BuildContext context) {
  return InputDecorationTheme(
    labelStyle: _labelTextStyle(),
    enabledBorder: _outlineEnabledBorder(context),
    focusedBorder: _outlineFocusedBorder(context),
    errorBorder: _outlineErrorBorder(context),
    focusedErrorBorder: _outlineErrorBorder(context),
    errorMaxLines: 2,
  );
}

// =====================================================================================
// MARK: - Border Styles
// =====================================================================================

OutlineInputBorder _outlineEnabledBorder(BuildContext context) {
  return OutlineInputBorder(
    borderSide: BorderSide(width: 1.0, color: Theme.of(context).colorScheme.primary),
    borderRadius: _borderRadius(),
  );
}

OutlineInputBorder _outlineFocusedBorder(BuildContext context) {
  return OutlineInputBorder(
    borderSide: BorderSide(width: 1.0, color: Theme.of(context).colorScheme.primary),
    borderRadius: _borderRadius(),
  );
}

OutlineInputBorder _outlineErrorBorder(BuildContext context) {
  return OutlineInputBorder(
    borderSide: BorderSide(width: 1.0, color: Theme.of(context).colorScheme.primary),
    borderRadius: _borderRadius(),
  );
}

BorderRadius _borderRadius() {
  return const BorderRadius.all(Radius.circular(5.0));
}

// =====================================================================================
// MARK: - Text Styles
// =====================================================================================

TextStyle _labelTextStyle() {
  return TextStyle(fontWeight: FontWeight.bold);
}
