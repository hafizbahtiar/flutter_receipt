import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_receipt/config/themes/app_theme.dart';
import 'package:flutter_receipt/modules/splash_page.dart';
import 'package:flutter_receipt/providers/user_pref_provider.dart';
import 'package:flutter_receipt/routes/generate_rote.dart';
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
    final prefsWatch = Provider.of<UserPrefsProvider>(context, listen: true);
    final themeMode = prefsWatch.themeMode;

    return MaterialApp(
      title: 'Flutter Receipt',
      locale: Locale(prefsWatch.languageCode),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: appThemeData(context, false),
      darkTheme: appThemeData(context, true),
      themeMode: themeMode,
      home: SplashPage(),
      initialRoute: '/',
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
          child: child!,
        );
      },
    );
  }
}
