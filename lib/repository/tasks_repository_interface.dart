import 'package:taskpad_flutter/models/task_model.dart';

abstract class ITasksRepository {
  Stream<List<TaskModel>> getTaskFromCurrentListStream();
  Future<void> addTask(TaskModel taskModel);
  Future<void> deleteTask(int taskID);
  List<TaskModel> getTaskModels();
}
