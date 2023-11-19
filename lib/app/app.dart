import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import 'theme_data/project_theme_data.dart';
import 'navigation/route_generator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String initialRoute = HomeScreen.routeName;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskPad',
      theme: ProjectThemeData.projectThemeData,
      initialRoute: initialRoute,
      onGenerateRoute: RouteGeneretor.generateRoute,
    );
  }
}
