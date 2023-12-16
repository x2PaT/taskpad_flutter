import 'package:flutter/material.dart';

import '../models/task_model.dart';

abstract class ITasksRepository {
  Future<void> addTask(TaskModel taskModel);
  Future<void> deleteTask(int taskID);

  List<TaskModel> getTaskModels();

  Listenable tasksListenable();
}
