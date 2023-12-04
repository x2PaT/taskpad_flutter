import '../models/list_model.dart';

abstract class IListsRepository {
  Future<void> addList(ListModel tasksListModel);
  Future<void> deleteList(int listID);
  Future<void> updateCurrentListId(int listID);
  Future<int?> getCurrentListId();

  List<ListModel> getListModels();
}
