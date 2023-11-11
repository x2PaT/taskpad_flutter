import 'package:taskpad_flutter/app/data/dao/task_dao.dart';
import 'package:taskpad_flutter/app/data/dao/tasks_list_dao.dart';
import 'package:taskpad_flutter/models/task_model.dart';
import 'package:taskpad_flutter/models/tasks_list_model.dart';
import 'package:taskpad_flutter/repository/tasks_repository_interface.dart';

import '../app/enums/enums.dart';

class TasksRepository implements ITasksRepository {
  TasksRepository({
    required this.taskDao,
    required this.tasksListsDao,
  });

  final TaskDao taskDao;
  final ListDao tasksListsDao;

  @override
  Future<void> addTask(int listID, TaskModel taskModel) async {
    await taskDao.addObject(taskModel.taskId, taskModel);
    await tasksListsDao.addTaskIDToTasksList(listID, taskModel.taskId);
  }

  @override
  List<TaskModel> getTasksFromListID(int listID) {
    final ListModel? listObject = tasksListsDao.readObjectByKey(listID);

    if (listObject == null) {
      throw Exception("Unknown list ID: $listID");
    }

    return taskDao.getTasksFromIDsList(listObject.listTasks);
  }

  @override
  Future<void> deleteTask(int taskID) async {
    await taskDao.deleteObject(taskID);
  }

  @override
  Future<void> updateTaskDispatcher(UpdateTaskActions action, TaskModel task, data) async {
    switch (action) {
      case UpdateTaskActions.updateText:
        await taskDao.updateTaskText(task, data);
        break;
      case UpdateTaskActions.updateChecked:
        await taskDao.updateTaskChecked(task, data);
        break;
      case UpdateTaskActions.updateDeleted:
        await taskDao.updateTaskDeleted(task, data);
        break;
      case UpdateTaskActions.updatePinned:
        await taskDao.updateTaskPinned(task, data);
        break;
    }
  }

  @override
  Stream<List<TaskModel>> getTaskModelFromListIDStream(int listID) {
    final ListModel? listObject = tasksListsDao.readObjectByKey(listID);

    if (listObject == null) {
      throw Exception("Unknown list ID: $listID");
    }

    return taskDao.readObjectsStream(keys: listObject.listTasks);
  }

  @override
  Future<void> clearTasksBox() async {
    await taskDao.clearBox();
  }

  @override
  int getAllTasksCount() {
    return taskDao.getAllObjects().length;
  }
}
