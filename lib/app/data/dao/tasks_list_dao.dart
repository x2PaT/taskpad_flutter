import '../../../models/tasks_list_model.dart';
import '../base_dao_impl.dart';

class TasksListsDao extends BaseDao<TasksListModel> {
  TasksListsDao(super.boxName);

  addTaskIDToTasksList(int listID, int taskID) {
    final listObject = readObjectByKey(listID);
    if (listObject == null) throw Exception("Invalid list ID");
    final newlistObject = TasksListModel(
      listID: listID,
      listTasks: [...listObject.listTasks, taskID],
    );
    addObject(listID, newlistObject);
  }
}
