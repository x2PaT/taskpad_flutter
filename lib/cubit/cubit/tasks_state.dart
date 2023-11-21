part of 'tasks_cubit.dart';

class TasksState {
  TasksState({
    this.tasks = const [],
    this.lists = const [],
    this.currentListId = -1,
  });

  final List<TaskModel> tasks;
  final List<ListModel> lists;
  final int currentListId;

  TasksState copyWith({
    List<TaskModel>? tasks,
    List<ListModel>? lists,
    int? currentListId,
  }) {
    return TasksState(
      tasks: tasks ?? this.tasks,
      lists: lists ?? this.lists,
      currentListId: currentListId ?? this.currentListId,
    );
  }

  @override
  String toString() => 'TasksState(tasks: $tasks, lists: $lists, currentListId: $currentListId)';
}
