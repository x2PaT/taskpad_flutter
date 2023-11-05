import '../../../models/tasks_list_model.dart';
import '../base_dao_impl.dart';

class TasksListsDao extends BaseDao<TasksListModel> {
  TasksListsDao(super.boxName);

  Future<void> addTaskIDToTasksList(int listID, int taskID) async {
    final TasksListModel? listObject = readObjectByKey(listID);
    if (listObject == null) throw Exception("Invalid list ID");
    final newlistObject = TasksListModel(
      listID: listID,
      listTasks: [...listObject.listTasks, taskID],
    );
    await addObject(listID, newlistObject);
  }

  Future<void> updateTasksOrder(int listID, TasksListModel model) async {
    await addObject(listID, model);
  }
}
