import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskpad_flutter/models/list_model.dart';

import '../../app/enums/enums.dart';
import '../../app/helpers/tast_gen.dart';
import '../../repository/lists_repository_interface.dart';
import '../../repository/tasks_repository_interface.dart';

part 'lists_state.dart';

class ListsCubit extends Cubit<ListsState> {
  ListsCubit({
    required this.listsRepository,
    required this.tasksRepository,
  }) : super(ListsState()) {
    start();
  }

  final ITasksRepository tasksRepository;
  final IListsRepository listsRepository;

  void start() {
    updateState();

    addListener();
  }

  void updateState() {
    emit(ListsState(status: Status.loading));

    final data = listsRepository.getListModels();
    emit(ListsState(listsModels: data, status: Status.success));
  }

  void addListener() {
    listsRepository.listsListenable().addListener(updateState);
  }

  void addList(String listName) {
    final listID = randomID();
    final newList = ListModel(listID: listID, listName: listName);
    listsRepository.addList(newList);
    changeCurrentList(newList);
  }

  deleteList(ListModel item) {
    listsRepository.deleteList(item.listID);
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
    listsRepository.updateCurrentListId(item.listID);
  }

  @override
  Future<void> close() {
    listsRepository.listsListenable().removeListener(updateState);
    return super.close();
  }
}
