import 'package:flutter/material.dart';

import 'di/di_service.dart';

class AppService {
  static final AppService instance = AppService._();
  AppService._();

  Future<void> init() async {
    
    WidgetsFlutterBinding.ensureInitialized();

    await _initHive();

    _initDI();
  }

  void _initDI() {
    DiService.instance.init();
  }

  Future<void> _initHive() async {}
}
