// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';

import '../app/constants/config.dart';

part 'task_model.g.dart';

@HiveType(typeId: Config.taskModelTypeID)
class TaskModel {
  TaskModel({
    required this.taskId,
    required this.listId,
    this.sortOrder = 2,
    required this.taskText,
    this.checked = false,
    this.deleted = false,
    this.pinned = false,
    DateTime? creationDate,
  }) : creationDate = creationDate ?? DateTime.now();

  @HiveField(0)
  final int taskId;
  @HiveField(1)
  final int listId;
  @HiveField(2)
  final int sortOrder;
  @HiveField(3)
  final String taskText;
  @HiveField(4)
  final bool checked;
  @HiveField(5)
  final bool deleted;
  @HiveField(6)
  final bool pinned;
  @HiveField(7)
  final DateTime creationDate;

  TaskModel copyWith({
    int? taskId,
    int? listId,
    int? sortOrder,
    String? taskText,
    bool? checked,
    bool? deleted,
    bool? pinned,
    DateTime? creationDate,
  }) {
    return TaskModel(
      taskId: taskId ?? this.taskId,
      listId: listId ?? this.listId,
      sortOrder: sortOrder ?? this.sortOrder,
      taskText: taskText ?? this.taskText,
      checked: checked ?? this.checked,
      deleted: deleted ?? this.deleted,
      pinned: pinned ?? this.pinned,
      creationDate: creationDate ?? this.creationDate,
    );
  }

  @override
  String toString() {
    return 'TaskModel(taskId: $taskId, listId: $listId, sortOrder: $sortOrder, taskText: $taskText, checked: $checked, deleted: $deleted, pinned: $pinned, creationDate: $creationDate)';
  }
}
