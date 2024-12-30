import 'package:flutter/material.dart';
import 'package:flutter_receipt/modules/home/home_page.dart';
import 'package:flutter_receipt/modules/setting/presentation/setting_page.dart';
import 'package:flutter_receipt/modules/splash_page.dart';
import 'package:flutter_receipt/routes/router_name.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouterName.splash:
        return MaterialPageRoute(builder: (_) => SplashPage(), settings: RouteSettings(name: RouterName.splash));
      case RouterName.home:
        return MaterialPageRoute(builder: (_) => HomePage(), settings: RouteSettings(name: RouterName.home));
      case RouterName.settings:
        return MaterialPageRoute(builder: (_) => SettingPage(), settings: RouteSettings(name: RouterName.settings));
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
