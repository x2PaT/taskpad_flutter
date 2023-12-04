// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tasks_cubit.dart';

class TasksState {}

class TasksStateInitial extends TasksState {}

class TasksStateLoading extends TasksState {}

class TasksStateLoaded extends TasksState {
  TasksStateLoaded({
    required this.tasks,
    required this.currentList,
  });

  final List<TaskModel> tasks;
  final ListModel currentList;

  TasksStateLoaded copyWith({
    List<TaskModel>? tasks,
    ListModel? currentList,
  }) {
    return TasksStateLoaded(
      tasks: tasks ?? this.tasks,
      currentList: currentList ?? this.currentList,
    );
  }

  @override
  String toString() => 'TasksStateLoaded(tasks: $tasks, currentList: $currentList)';
}
