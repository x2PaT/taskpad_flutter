import 'package:taskpad_flutter/models/task_model.dart';
import 'package:taskpad_flutter/models/tasks_list_model.dart';

abstract class ITasksRepository {
  void addTasksList(TasksListModel tasksListModel);
  void addTask(int listID, TaskModel taskModel);
  List<TasksListModel> getTasksListModels();
  List<TaskModel> getTasksForListID(int listID);
}
