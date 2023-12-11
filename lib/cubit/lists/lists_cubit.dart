
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskpad_flutter/app/data/dao/settings_dao.dart';
import 'package:taskpad_flutter/models/list_model.dart';

import '../../app/constants/config.dart';
import '../../app/enums/enums.dart';
import '../../models/setting_model.dart';
import '../../models/task_model.dart';
import '../tasks/tasks_cubit.dart';

part 'lists_state.dart';

class ListsCubit extends Cubit<ListsState> {
  ListsCubit() : super(ListsState()) {
    start();
  }

  final Box<ListModel> listBox = Hive.box<ListModel>(Config.listsBoxName);
  final Box<TaskModel> box = Hive.box<TaskModel>(Config.tasksBoxName);

  final Box<SettingModel> settingsBox = Hive.box<SettingModel>(Config.settingsBoxName);

  void start() {
    updateState();

    addListener();
  }

  void updateState() {
    emit(ListsState(status: Status.loading));

    final data = listBox.values.toList();
    emit(ListsState(listsModels: data, status: Status.success));
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

  void addList(String listName) {
    final listID = randomID();
    // "${Random().nextInt(20)} list")
    final newList = (ListModel(listID: listID, listName: listName));
    listBox.put(listID, newList);
    changeCurrentList(newList);
  }

  deleteList(ListModel item) {
    listBox.delete(item.listID);
    box.deleteAll(
      box.values.where((element) => element.listId == item.listID).map((e) => e.taskId),
    );
  }

  void changeToNextList({required ListModel currentList}) {
    final nextListOrNull = state.nextList(currentList);
    if (nextListOrNull != null) {
      changeCurrentList(nextListOrNull);
    }
  }

  void changeToPrevList({required ListModel currentList}) {
    final prevListOrNull = state.prevList(currentList);
    if (prevListOrNull != null) {
      changeCurrentList(prevListOrNull);
    }
  }

  changeCurrentList(ListModel item) {
    settingsBox.put(SettingsDao.currentListKey,
        SettingModel(key: SettingsDao.currentListKey, value: item.listID));
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
