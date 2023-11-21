import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../dev_helpers/colored_prints.dart';
import '../../models/list_model.dart';
import '../../models/task_model.dart';
import '../../repository/lists_repository_interface.dart';
import '../../repository/tasks_repository_interface.dart';

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

    tasksRepository.currentListIdStream().listen((event) {
      printR("object currentListId");

      emit(state.copyWith(currentListId: event));
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

  void showNextList() {
    final currentListIndex = state.lists.map((e) => e.listID).toList().indexOf(state.currentListId);
    final newListId = state.lists[(currentListIndex + 1) % state.lists.length].listID;

    changeCurrentList(newListId);
  }

  showPrevList() {
    final currentListIndex = state.lists.map((e) => e.listID).toList().indexOf(state.currentListId);
    final newListId = state.lists[(currentListIndex - 1) % state.lists.length].listID;

    changeCurrentList(newListId);
  }
}

int randomID() {
  return Random().nextInt(0xFFFFFF);
}
