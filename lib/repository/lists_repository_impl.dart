import 'package:flutter/foundation.dart';
import 'package:taskpad_flutter/app/data/dao/task_dao.dart';
import 'package:taskpad_flutter/app/data/dao/tasks_list_dao.dart';
import 'package:taskpad_flutter/models/list_model.dart';
import 'package:taskpad_flutter/repository/lists_repository_interface.dart';

import '../app/data/dao/settings_dao.dart';

class ListsRepository implements IListsRepository {
  ListsRepository({
    required this.taskDao,
    required this.listDao,
    required this.settingsDao,
  });

  final ListDao listDao;
  final TaskDao taskDao;
  final SettingsDao settingsDao;

  @override
  Future<void> addList(ListModel tasksListModel) async {
    await listDao.addObject(tasksListModel.listID, tasksListModel);
  }

  @override
  Future<void> deleteList(int listID) async {
    await listDao.deleteObject(listID);

    taskDao.deleteAll(
      taskDao
          .getAllObjects()
          .where((element) => element.listId == listID)
          .map((e) => e.taskId)
          .toList(),
    );
  }

  @override
  Future<void> updateCurrentListId(int listID) async {
    await settingsDao.writeCurrentListID(listID);
  }

  @override
  Future<int?> getCurrentListId() async {
    return settingsDao.readCurrentListIDValue();
  }

  @override
  List<ListModel> getListModels() {
    return listDao.getAllObjects();
  }

  @override
  ListModel? getCurrentListModel() {
    return listDao.readObjectByKey(settingsDao.readObjectByKey(SettingsDao.currentListKey)?.value);
  }

  @override
  Listenable listsListenable() {
    return Listenable.merge(
      [listDao.listenable()],
    );
  }
}
