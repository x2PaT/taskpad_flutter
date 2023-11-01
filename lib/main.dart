import 'package:flutter/material.dart';
import 'app/app.dart';
import 'app/app_service.dart';

void main() async {
  await AppService.instance.init();

  runApp(
    const MyApp(),
  );
}
