import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app/helpers/tast_gen.dart';
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
  }) : super(TasksStateInitial()) {
    start();
  }

  final ITasksRepository tasksRepository;
  final IListsRepository listsRepository;

  void start() {
    emit(TasksStateLoading());

    updateState();

    addListener();
  }

  void updateState() {
    final currentList = listsRepository.getCurrentListModel();

    final tasksList = tasksRepository
        .getTaskModels()
        .where((element) => element.listId == currentList?.listID)
        .toList();

    if (currentList == null) {
      emit(TasksStateListNotExist());
    } else {
      emit(TasksStateLoaded(tasks: tasksList, currentList: currentList));
    }
  }

  void addListener() {
    tasksRepository.tasksListenable().addListener(updateState);
  }

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

  Future<void> addTask(String title) async {
    final currentListID = await listsRepository.getCurrentListId();

    await tasksRepository.addTask(
      TaskModel(
        taskId: randomID(),
        listId: currentListID!,
        taskText: title,
      ),
    );
  }

  Future<void> addTaskGen() async {
    final currentListID = await listsRepository.getCurrentListId();

    final String taskTitle = createTaskTitle();

    await tasksRepository.addTask(
      TaskModel(
        taskId: randomID(),
        listId: currentListID!,
        taskText: taskTitle,
      ),
    );
  }

  @override
  Future<void> close() {
    tasksRepository.tasksListenable().removeListener(updateState);
    return super.close();
  }
}
