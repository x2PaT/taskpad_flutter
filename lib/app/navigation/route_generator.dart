import 'package:flutter/material.dart';
import 'package:taskpad_flutter/screens/home_screen.dart';

import 'error_screen.dart';

class RouteGeneretor {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => ErrorScreen(
            routeName: settings.name,
            error: 'Wrong route name',
          ),
        );
    }
  }
}
