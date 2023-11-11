import '../models/tasks_list_model.dart';

abstract class IListsRepository {
  Stream<List<ListModel>> getListModelsStream();
  List<ListModel> getListModels();
  Future<void> addList(ListModel tasksListModel);
  void updateTasksOrder(int listID, ListModel model);
  Future<void> clearListsBox();
  Future<void> deleteList(int listID);
}
