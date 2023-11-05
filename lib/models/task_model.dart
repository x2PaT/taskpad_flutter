import '../app/constants/config.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'task_model.g.dart';

@HiveType(typeId: Config.taskModelTypeID)
class TaskModel {
  TaskModel({
    required this.taskId,
    required this.taskText,
    this.checked = false,
    this.deleted = false,
    this.pinned = false,
    DateTime? creationDate,
  }) : creationDate = creationDate ?? DateTime.now();

  @HiveField(0)
  final int taskId;
  @HiveField(1)
  final String taskText;
  @HiveField(2)
  final bool checked;
  @HiveField(3)
  final bool deleted;
  @HiveField(4)
  final bool pinned;
  @HiveField(5)
  final DateTime creationDate;
}
