import 'package:flutter/material.dart';

class AnimatedNavigation {
  static PageRouteBuilder fadePageRoute(Widget page, String routeName) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end);
        var opacityAnimation = animation.drive(tween.chain(CurveTween(curve: curve)));

        return FadeTransition(opacity: opacityAnimation, child: child);
      },
      settings: RouteSettings(name: routeName),
    );
  }

  static PageRouteBuilder scalePageRoute(Widget page, String routeName) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.5;
        const end = 1.0;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end);
        var scaleAnimation = animation.drive(tween.chain(CurveTween(curve: curve)));

        return ScaleTransition(scale: scaleAnimation, child: child);
      },
      settings: RouteSettings(name: routeName),
    );
  }

  static PageRouteBuilder rotationPageRoute(Widget page, String routeName) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end);
        var rotationAnimation = animation.drive(tween.chain(CurveTween(curve: curve)));

        return RotationTransition(turns: rotationAnimation, child: child);
      },
      settings: RouteSettings(name: routeName),
    );
  }

  static PageRouteBuilder scaleAndFadePageRoute(Widget page, String routeName) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.5;
        const end = 1.0;
        const fadeBegin = 0.0;
        const fadeEnd = 1.0;
        const curve = Curves.easeInOut;

        var scaleTween = Tween(begin: begin, end: end);
        var scaleAnimation = animation.drive(scaleTween.chain(CurveTween(curve: curve)));

        var fadeTween = Tween(begin: fadeBegin, end: fadeEnd);
        var fadeAnimation = animation.drive(fadeTween.chain(CurveTween(curve: curve)));

        return FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(scale: scaleAnimation, child: child),
        );
      },
      settings: RouteSettings(name: routeName),
    );
  }

  static PageRouteBuilder slideFromRightPageRoute(
    Widget page,
    String routeName, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween.chain(CurveTween(curve: curve)));

        return SlideTransition(position: offsetAnimation, child: child);
      },
      settings: RouteSettings(name: routeName),
      transitionDuration: duration,
      reverseTransitionDuration: duration,
    );
  }

  static PageRouteBuilder slideFromBottomPageRoute(
    Widget page,
    String routeName, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween.chain(CurveTween(curve: curve)));

        return SlideTransition(position: offsetAnimation, child: child);
      },
      settings: RouteSettings(name: routeName),
      transitionDuration: duration,
      reverseTransitionDuration: duration,
    );
  }

  static PageRouteBuilder slideFromLeftPageRoute(
    Widget page,
    String routeName, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween.chain(CurveTween(curve: curve)));

        return SlideTransition(position: offsetAnimation, child: child);
      },
      settings: RouteSettings(name: routeName),
      transitionDuration: duration,
      reverseTransitionDuration: duration,
    );
  }

  static PageRouteBuilder slideFromTopPageRoute(
    Widget page,
    String routeName, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, -1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween.chain(CurveTween(curve: curve)));

        return SlideTransition(position: offsetAnimation, child: child);
      },
      settings: RouteSettings(name: routeName),
      transitionDuration: duration,
      reverseTransitionDuration: duration,
    );
  }

  static PageRouteBuilder bottomUpPageRoute(Widget page, String routeName) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween.chain(CurveTween(curve: curve)));

        return SlideTransition(position: offsetAnimation, child: child);
      },
      settings: RouteSettings(name: routeName),
    );
  }
}
