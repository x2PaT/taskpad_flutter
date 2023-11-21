import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskpad_flutter/dev_helpers/colored_prints.dart';
import 'package:taskpad_flutter/models/list_model.dart';
import 'package:taskpad_flutter/models/task_model.dart';
import 'package:taskpad_flutter/repository/lists_repository_interface.dart';
import 'package:taskpad_flutter/repository/tasks_repository_interface.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit({
    required this.listsRepository,
    required this.tasksRepository,
  }) : super(TasksState()) {
    initApp().then(
      (value) => getTasks(),
    );
  }
  final ITasksRepository tasksRepository;
  final IListsRepository listsRepository;

  void getTasks() {
    printC("TasksCubit getTasks");

    listsRepository.getListsStream().listen((event) {
      printR("object lists");

      emit(state.copyWith(lists: event));
    });

    tasksRepository.getTaskFromCurrentListStream().listen((event) {
      printR("object tasks");

      emit(state.copyWith(tasks: event));
    });
  }

  // Future<void> forceStreamInit() async {
  //   final currentListID = await listsRepository.getCurrentListId();
  //   await listsRepository.updateCurrentListId(currentListID!);

  //   final taskId = randomID();
  //   await tasksRepository.addTask(TaskModel(
  //       taskId: taskId,
  //       listId: currentListID,
  //       taskText: "list id:$currentListID on task id:$taskId"));
  // }

  Future<void> initApp() async {
    final currentListID = await listsRepository.getCurrentListId();
    printR("Current listID $currentListID");

    const forceInit = false;

    if (currentListID == null || forceInit) {
      for (var i = 0; i < 5; i++) {
        final listID = randomID();

        await listsRepository.updateCurrentListId(listID);

        await listsRepository.addList(ListModel(listID: listID, listName: "$i list"));
        for (var j = 0; j < Random().nextInt(5 + 5); j++) {
          final taskId = randomID();
          await tasksRepository.addTask(TaskModel(
              taskId: taskId,
              listId: listID,
              taskText: "task $j(id:$listID) on list $i(id:$taskId) "));
        }
      }
    }
  }

  void changeCurrentList(int listId) {
    listsRepository.updateCurrentListId(listId);
  }

  Future<void> deleteTask(int taskID) async {
    tasksRepository.deleteTask(taskID);
  }

  Future<void> addTask() async {
    final currentListID = await listsRepository.getCurrentListId();

    await tasksRepository.addTask(
      TaskModel(
        taskId: randomID(),
        listId: currentListID!,
        taskText: "New task",
      ),
    );
  }
}

int randomID() {
  return Random().nextInt(0xFFFFFF);
}
