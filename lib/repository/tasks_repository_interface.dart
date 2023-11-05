import 'package:taskpad_flutter/models/task_model.dart';
import 'package:taskpad_flutter/models/tasks_list_model.dart';

import 'enums.dart';

abstract class ITasksRepository {
  Future<void> initBoxes();
  Future<void> addTasksList(TasksListModel tasksListModel);
  Future<void> addTask(int listID, TaskModel taskModel);
  List<TasksListModel> getTasksListModels();
  List<TaskModel> getTasksForListID(int listID);
  Future<void> deleteTask(int taskID);
  Future<void> deleteTasksList(int listID);
  void updateTasksOrder(int listID, TasksListModel model);
  void updateTaskDispatcher(UpdateTaskActions actions, TaskModel task, dynamic data);
}
