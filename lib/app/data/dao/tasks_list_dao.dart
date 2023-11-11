import '../../../models/tasks_list_model.dart';
import '../base_dao_impl.dart';

class ListDao extends BaseDao<ListModel> {
  ListDao(super.boxName);

  Future<void> addTaskIDToTasksList(int listID, int taskID) async {
    final ListModel? listObject = readObjectByKey(listID);
    if (listObject == null) throw Exception("Invalid list ID");
    final newlistObject = ListModel(
      listID: listID,
      listTasks: [...listObject.listTasks, taskID],
    );
    await addObject(listID, newlistObject);
  }

  Future<void> updateTasksOrder(int listID, ListModel model) async {
    await addObject(listID, model);
  }
}
