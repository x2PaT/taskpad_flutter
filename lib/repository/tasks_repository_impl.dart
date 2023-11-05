import 'package:taskpad_flutter/app/data/dao/task_dao.dart';
import 'package:taskpad_flutter/app/data/dao/tasks_list_dao.dart';
import 'package:taskpad_flutter/models/task_model.dart';
import 'package:taskpad_flutter/models/tasks_list_model.dart';
import 'package:taskpad_flutter/repository/tasks_repository_interface.dart';

import 'enums.dart';

class TasksRepository implements ITasksRepository {
  TasksRepository({
    required this.taskDao,
    required this.tasksListsDao,
  });

  final TaskDao taskDao;
  final TasksListsDao tasksListsDao;

//TODO: make auto init
// software cant wait for async function in class constructor body.
  @override
  Future<void> initBoxes() async {
    await taskDao.initBox();
    await tasksListsDao.initBox();
  }

  @override
  Future<void> addTask(int listID, TaskModel taskModel) async {
    await taskDao.addObject(taskModel.taskId, taskModel);
    await tasksListsDao.addTaskIDToTasksList(listID, taskModel.taskId);
  }

  @override
  Future<void> addTasksList(TasksListModel tasksListModel) async {
    await tasksListsDao.addObject(tasksListModel.listID, tasksListModel);
  }

  @override
  List<TaskModel> getTasksForListID(int listID) {
    final TasksListModel? listObject = tasksListsDao.readObjectByKey(listID);

    if (listObject == null) {
      throw Exception("Unknown list ID: $listID");
    }

    return taskDao.getTasksFromIDsList(listObject.listTasks);
  }

  @override
  List<TasksListModel> getTasksListModels() {
    return tasksListsDao.getAllObjects();
  }

  @override
  Future<void> deleteTask(int taskID) async {
    await taskDao.deleteObject(taskID);
  }

  @override
  Future<void> deleteTasksList(int listID) async {
    await tasksListsDao.deleteObject(listID);
  }

  @override
  void updateTasksOrder(int listID, TasksListModel model) {
    tasksListsDao.updateTasksOrder(listID, model);
  }

  @override
  void updateTaskDispatcher(UpdateTaskActions action, TaskModel task, data) {
    switch (action) {
      case UpdateTaskActions.updateText:
        taskDao.updateTaskText(task, data);
        break;
      case UpdateTaskActions.updateChecked:
        taskDao.updateTaskChecked(task, data);
        break;
      case UpdateTaskActions.updateDeleted:
        taskDao.updateTaskDeleted(task, data);
        break;
      case UpdateTaskActions.updatePinned:
        taskDao.updateTaskPinned(task, data);
        break;
    }
  }
}
