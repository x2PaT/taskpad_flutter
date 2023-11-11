import 'package:taskpad_flutter/repository/lists_repository_interface.dart';

import '../app/data/dao/task_dao.dart';
import '../app/data/dao/tasks_list_dao.dart';
import '../models/tasks_list_model.dart';

class ListsRepository implements IListsRepository {
  ListsRepository({
    required this.taskDao,
    required this.tasksListsDao,
  });

  final TaskDao taskDao;
  final ListDao tasksListsDao;

  @override
  Future<void> addList(ListModel tasksListModel) async {
    await tasksListsDao.addObject(tasksListModel.listID, tasksListModel);
  }

  @override
  List<ListModel> getListModels() {
    return tasksListsDao.getAllObjects();
  }

  @override
  Future<void> deleteList(int listID) async {
    final listmodel = tasksListsDao.readObjectByKey(listID);
    final listTasks = listmodel?.listTasks ?? [];

    for (var id in listTasks) {
      await taskDao.deleteObject(id);
    }

    await tasksListsDao.deleteObject(listID);
  }

  @override
  Future<void> updateTasksOrder(int listID, ListModel model) async {
    await tasksListsDao.updateTasksOrder(listID, model);
  }

  @override
  Stream<List<ListModel>> getListModelsStream() {
    return tasksListsDao.readObjectsStream();
  }

  @override
  Future<void> clearListsBox() async {
    await tasksListsDao.clearBox();
  }
}
