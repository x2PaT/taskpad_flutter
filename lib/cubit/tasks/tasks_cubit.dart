import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskpad_flutter/app/data/dao/settings_dao.dart';
import '../../app/constants/config.dart';
import '../../dev_helpers/colored_prints.dart';
import '../../models/list_model.dart';
import '../../models/setting_model.dart';
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

  final Box<TaskModel> box = Hive.box<TaskModel>(Config.tasksBoxName);
  final Box<ListModel> listBox = Hive.box<ListModel>(Config.listsBoxName);
  final Box<SettingModel> settingsBox = Hive.box<SettingModel>(Config.settingsBoxName);

  final ITasksRepository tasksRepository;
  final IListsRepository listsRepository;

  void start() {
    emit(TasksStateLoading());

    updateState();

    addListener();
  }

  void updateState() {
    final currentList = listBox.get(settingsBox.get(SettingsDao.currentListKey)?.value);

    final tasksList = box.values.where((element) => element.listId == currentList?.listID).toList();

    emit(TasksStateLoaded(tasks: tasksList, currentList: currentList!));
  }

  void addListener() {
    Listenable.merge(
      [
        box.listenable(),
        listBox.listenable(),
        settingsBox.listenable(
          keys: [SettingsDao.currentListKey],
        )
      ],
    ).addListener(updateState);
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
