import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_receipt/core/utils/shared_prefs.dart';
import 'package:flutter_receipt/data/config/database_helper.dart';
import 'package:flutter_receipt/my_app.dart';
import 'package:flutter_receipt/providers/providers.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await SharedPrefs().init();
  await DatabaseHelper().database;
  runApp(
    MultiProvider(
      providers: Providers.providers,
      child: const MyApp(),
    ),
  );
}
