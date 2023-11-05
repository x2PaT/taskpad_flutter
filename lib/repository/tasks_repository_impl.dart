import 'package:taskpad_flutter/app/data/dao/task_dao.dart';
import 'package:taskpad_flutter/app/data/dao/tasks_list_dao.dart';
import 'package:taskpad_flutter/dev_helpers/colored_prints.dart';
import 'package:taskpad_flutter/models/task_model.dart';
import 'package:taskpad_flutter/models/tasks_list_model.dart';
import 'package:taskpad_flutter/repository/tasks_repository_interface.dart';

class TasksRepository implements ITasksRepository {
  TasksRepository({
    required this.taskDao,
    required this.tasksListsDao,
  });

  final TaskDao taskDao;
  final TasksListsDao tasksListsDao;

//TODO: make auto init
// software cant wait for async function in class constructor body.
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
      throw Exception("Cant read list object.Unkown list ID: $listID. At getTasksForListID");
    }
    printB(listObject.listTasks);
    return listObject.listTasks.map(
      (int taskID) {
        final item = taskDao.readObjectByKey(taskID);
        if (item == null) {
          throw Exception("Cant read task object.Unkown task ID: $taskID. At getTasksForListID");
        } else {
          return item;
        }
      },
    ).toList();
  }

  @override
  List<TasksListModel> getTasksListModels() {
    return tasksListsDao.getAllObjects();
  }
}
