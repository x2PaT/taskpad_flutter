// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tasks_cubit.dart';

class TasksState {
  TasksState({
    this.tasks = const [],
    this.lists = const [],
  });

  final List<TaskModel> tasks;
  final List<ListModel> lists;

  TasksState copyWith({
    List<TaskModel>? tasks,
    List<ListModel>? lists,
  }) {
    return TasksState(
      tasks: tasks ?? this.tasks,
      lists: lists ?? this.lists,
    );
  }

  @override
  String toString() => 'TasksState(tasks: $tasks, lists: $lists)';
}
