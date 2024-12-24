import 'package:flutter/material.dart';
import 'package:flutter_receipt/my_app.dart';
import 'package:flutter_receipt/providers/providers.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: Providers.providers,
      child: const MyApp(),
    ),
  );
}