import '../app/constants/config.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'task_model.g.dart';

@HiveType(typeId: Config.taskModelTypeID)
class TaskModel {
  TaskModel({
    required this.id,
    required this.listId,
    required this.taskText,
    required this.checked,
    required this.deleted,
    required this.pinned,
    DateTime? creationDate,
  }) : creationDate = creationDate ?? DateTime.now();

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String listId;
  @HiveField(2)
  final String taskText;
  @HiveField(3)
  final bool checked;
  @HiveField(4)
  final bool deleted;
  @HiveField(5)
  final bool pinned;
  @HiveField(6)
  final DateTime creationDate;
}
