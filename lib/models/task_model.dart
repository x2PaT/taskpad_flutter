import 'package:hive_flutter/hive_flutter.dart';

import '../app/constants/config.dart';

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

  TaskModel copyWith({
    int? taskId,
    String? taskText,
    bool? checked,
    bool? deleted,
    bool? pinned,
  }) {
    return TaskModel(
      taskId: taskId ?? this.taskId,
      taskText: taskText ?? this.taskText,
      checked: checked ?? this.checked,
      deleted: deleted ?? this.deleted,
      pinned: pinned ?? this.pinned,
      creationDate: creationDate,
    );
  }

  @override
  String toString() {
    return 'TaskModel(taskId: $taskId, taskText: $taskText, checked: $checked, deleted: $deleted, pinned: $pinned, creationDate: $creationDate)';
  }
}
