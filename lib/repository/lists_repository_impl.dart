
import 'package:rxdart/rxdart.dart';
import 'package:taskpad_flutter/app/data/dao/tasks_list_dao.dart';
import 'package:taskpad_flutter/models/list_model.dart';
import 'package:taskpad_flutter/repository/lists_repository_interface.dart';

import '../app/data/dao/settings_dao.dart';

class ListsRepository implements IListsRepository {
  ListsRepository({
    required this.listDao,
    required this.settingsDao,
  });

  final ListDao listDao;
  final SettingsDao settingsDao;

  @override
  Stream<List<ListModel>> getListsStream() {
    return listDao.readObjectsStream().startWith(listDao.getAllObjects());
  }

  @override
  Future<void> addList(ListModel tasksListModel) async {
    await listDao.addObject(tasksListModel.listID, tasksListModel);
  }

  @override
  Future<void> deleteList(int listID) async {
    await listDao.deleteObject(listID);
  }

  @override
  Future<void> updateCurrentListId(int listID) async {
    await settingsDao.writeCurrentListID(listID);
  }

  @override
  Future<int?> getCurrentListId() async {
    return settingsDao.readCurrentListIDValue();
  }
}
