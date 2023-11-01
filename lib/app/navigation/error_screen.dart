import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.routeName, required this.error});

  final String? routeName;
  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route error'),
      ),
      body: Center(
        child: Text(
          'Error with routes.\n Error: $error\n Route: $routeName',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
