import '../../../models/task_model.dart';
import '../base_dao_impl.dart';

class TaskDao extends BaseDao<TaskModel> {
  TaskDao(super.boxName);

  void updateTaskText(TaskModel task, dynamic data) {
    if (data is String) {
      task = task.copyWith(taskText: data);
      addObject(task.taskId, task);
    } else {
      throw Exception("Wrong data type");
    }
  }

  void updateTaskChecked(TaskModel task, dynamic data) {
    if (data is bool) {
      task = task.copyWith(checked: data);
      addObject(task.taskId, task);
    } else {
      throw Exception("Wrong data type");
    }
  }

  void updateTaskDeleted(TaskModel task, dynamic data) {
    if (data is bool) {
      task = task.copyWith(deleted: data);
      addObject(task.taskId, task);
    } else {
      throw Exception("Wrong data type");
    }
  }

  void updateTaskPinned(TaskModel task, dynamic data) {
    if (data is bool) {
      task = task.copyWith(pinned: data);
      addObject(task.taskId, task);
    } else {
      throw Exception("Wrong data type");
    }
  }

  List<TaskModel> getTasksFromIDsList(List<int> listTasks) {
    final List<TaskModel> tasks = [];
    for (int taskID in listTasks) {
      final TaskModel? task = readObjectByKey(taskID);
      if (task == null) {
        throw Exception("Unknown task ID: $taskID");
      } else {
        tasks.add(task);
      }
    }

    return tasks;
  }
}
