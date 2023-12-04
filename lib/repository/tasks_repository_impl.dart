import 'package:taskpad_flutter/app/data/dao/settings_dao.dart';
import 'package:taskpad_flutter/app/data/dao/task_dao.dart';
import 'package:taskpad_flutter/app/data/dao/tasks_list_dao.dart';
import 'package:taskpad_flutter/models/task_model.dart';
import 'package:taskpad_flutter/repository/tasks_repository_interface.dart';

class TasksRepository implements ITasksRepository {
  TasksRepository({
    required this.taskDao,
    required this.settingsDao,
    required this.listDao,
  });

  final TaskDao taskDao;
  final SettingsDao settingsDao;
  final ListDao listDao;
  @override
  Future<void> addTask(TaskModel taskModel) async {
    await taskDao.addObject(taskModel.taskId, taskModel);
  }

  @override
  Future<void> deleteTask(int taskID) async {
    await taskDao.deleteObject(taskID);
  }

  @override
  List<TaskModel> getTaskModels() {
    return taskDao.getAllObjects();
  }
}
