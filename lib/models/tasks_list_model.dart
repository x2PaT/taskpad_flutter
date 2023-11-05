import 'package:hive_flutter/hive_flutter.dart';

import '../app/constants/config.dart';

part 'tasks_list_model.g.dart';

@HiveType(typeId: Config.tasksListModelTypeID)
class TasksListModel {
  TasksListModel({
    required this.listID,
    required this.listTasks,
  });

  @HiveField(0)
  final int listID;
  @HiveField(1)
  final List<int> listTasks;
}
