import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_receipt/modules/home/home_page.dart';
import 'package:flutter_receipt/config/themes/app_theme.dart';
import 'package:flutter_receipt/providers/user_pref_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final prefsProvider = Provider.of<UserPrefsProvider>(context, listen: false);
      prefsProvider.initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    final prefsWatch = Provider.of<UserPrefsProvider>(context);

    return MaterialApp(
      title: 'Flutter Receipt',
      locale: Locale(prefsWatch.languageCode),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: appThemeData(context, false),
      darkTheme: appThemeData(context, true),
      themeMode: prefsWatch.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const MyHomePage(),
    );
  }
}
