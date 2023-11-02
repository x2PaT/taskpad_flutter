import 'package:hive_flutter/hive_flutter.dart';

part 'setting_model.g.dart';

@HiveType(typeId: 1)
class SettingModel {
  SettingModel({
    required this.key,
    required this.value,
  });

  @HiveField(0)
  final int key;
  @HiveField(1)
  final dynamic value;
}
