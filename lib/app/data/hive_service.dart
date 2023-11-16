import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskpad_flutter/app/constants/config.dart';
import 'package:taskpad_flutter/models/setting_model.dart';
import 'package:taskpad_flutter/models/task_model.dart';
import 'package:taskpad_flutter/models/list_model.dart';

class HiveService {
  HiveService._();

  static final HiveService instance = HiveService._();

  Future<void> init() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter<TaskModel>((TaskModelAdapter()))
      ..registerAdapter<ListModel>((ListModelAdapter()))
      ..registerAdapter<SettingModel>((SettingModelAdapter()));

    await Hive.openBox<TaskModel>(Config.tasksBoxName);
    await Hive.openBox<ListModel>(Config.lisksBoxName);
    await Hive.openBox<SettingModel>(Config.settingsBoxName);
  }
}
