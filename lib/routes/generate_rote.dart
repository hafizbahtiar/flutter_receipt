import 'package:flutter/material.dart';
import 'package:flutter_receipt/modules/home/features/home_add_page.dart';
import 'package:flutter_receipt/modules/home/presentation/pages/home_page.dart';
import 'package:flutter_receipt/modules/setting/features/expenses_category/presentation/setting_expenses_category_page.dart';
import 'package:flutter_receipt/modules/setting/features/income_category/presentation/setting_income_category_page.dart';
import 'package:flutter_receipt/modules/setting/features/language/setting_language_page.dart';
import 'package:flutter_receipt/modules/setting/features/tax/setting_tax_page.dart';
import 'package:flutter_receipt/modules/setting/features/theme_mode/setting_theme_mode_page.dart';
import 'package:flutter_receipt/modules/setting/presentation/setting_page.dart';
import 'package:flutter_receipt/modules/splash_page.dart';
import 'package:flutter_receipt/routes/animated_navigator.dart';
import 'package:flutter_receipt/routes/router_name.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterName.splash:
        return MaterialPageRoute(
          builder: (_) => SplashPage(),
          settings: RouteSettings(name: RouterName.splash),
        );
      case RouterName.home:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
          settings: RouteSettings(name: RouterName.home),
        );
      case RouterName.homeAdd:
        // return MaterialPageRoute(
        //   builder: (_) => HomeAddPage(),
        //   settings: RouteSettings(name: RouterName.homeAdd),
        // );
        return AnimatedNavigation.slideFromBottomPageRoute(
          HomeAddPage(),
          RouterName.homeAdd,
        );
      case RouterName.settings:
        return MaterialPageRoute(
          builder: (_) => SettingPage(),
          settings: RouteSettings(name: RouterName.settings),
        );
      case RouterName.settingsThemeMode:
        return MaterialPageRoute(
          builder: (_) => SettingThemeModePage(),
          settings: RouteSettings(name: RouterName.settingsThemeMode),
        );
      case RouterName.settingsLanguage:
        return MaterialPageRoute(
          builder: (_) => SettingLanguagePage(),
          settings: RouteSettings(name: RouterName.settingsLanguage),
        );
      case RouterName.settingsIncomeCategory:
        return MaterialPageRoute(
          builder: (_) => SettingIncomeCategoryPage(),
          settings: RouteSettings(name: RouterName.settingsIncomeCategory),
        );
      case RouterName.settingsExpensesCategory:
        return MaterialPageRoute(
          builder: (_) => SettingExpensesCategoryPage(),
          settings: RouteSettings(name: RouterName.settingsExpensesCategory),
        );
      case RouterName.settingsTax:
        return MaterialPageRoute(
          builder: (_) => SettingTaxPage(),
          settings: RouteSettings(name: RouterName.settingsTax),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR: Route not found'),
        ),
      );
    });
  }
}
