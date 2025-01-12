import 'package:flutter/material.dart';

AppBarTheme appBarTheme(BuildContext context) {
  return AppBarTheme(
    backgroundColor: Theme.of(context).colorScheme.primary,
    foregroundColor: Theme.of(context).colorScheme.onPrimary,
    centerTitle: true,
    elevation: 0,
    iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
    actionsIconTheme: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
  );
}
