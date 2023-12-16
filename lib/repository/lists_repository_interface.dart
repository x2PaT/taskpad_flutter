import 'package:flutter/foundation.dart';

import '../models/list_model.dart';

abstract class IListsRepository {
  Future<void> addList(ListModel tasksListModel);
  Future<void> deleteList(int listID);
  Future<void> updateCurrentListId(int listID);
  Future<int?> getCurrentListId();

  ListModel? getCurrentListModel();
  List<ListModel> getListModels();

  Listenable listsListenable();
}
