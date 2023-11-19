import '../models/list_model.dart';

abstract class IListsRepository {
  Stream<List<ListModel>> getListsStream();
  Future<void> addList(ListModel tasksListModel);
  Future<void> deleteList(int listID);
  Future<void> updateCurrentListId(int listID);
  Future<void> getCurrentListId();
}
