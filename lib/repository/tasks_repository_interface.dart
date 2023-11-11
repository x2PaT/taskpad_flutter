import 'package:taskpad_flutter/models/task_model.dart';

import '../app/enums/enums.dart';

abstract class ITasksRepository {
  Stream<List<TaskModel>> getTaskModelFromListIDStream(int listID);
  List<TaskModel> getTasksFromListID(int listID);
  Future<void> addTask(int listID, TaskModel taskModel);
  void updateTaskDispatcher(UpdateTaskActions actions, TaskModel task, dynamic data);
  Future<void> clearTasksBox();
  Future<void> deleteTask(int taskID);

  int getAllTasksCount();
}
