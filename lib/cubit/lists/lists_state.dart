// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'lists_cubit.dart';

class ListsState {
  ListsState({
    this.listsModels = const [],
    this.status = Status.initial,
  });

  final List<ListModel> listsModels;
  final Status status;

  ListModel? prevList(ListModel currentList) {
    if (!isPrevList(currentList)) return null;
    final currentListIndex = listsModels.indexOf(currentList);
    final prevListModel = listsModels[currentListIndex - 1];
    return prevListModel;
  }

  ListModel? nextList(ListModel currentList) {
    if (!isNextList(currentList)) return null;
    final currentListIndex = listsModels.indexOf(currentList);
    final prevListModel = listsModels[currentListIndex + 1];
    return prevListModel;
  }

  bool isPrevList(ListModel currentList) {
    final currentListIndex = listsModels.indexOf(currentList);
    return currentListIndex > 0;
  }

  bool isNextList(ListModel currentList) {
    final currentListIndex = listsModels.indexOf(currentList);
    return currentListIndex != listsModels.length - 1;
  }

  ListsState copyWith({
    List<ListModel>? listsModels,
    Status? status,
  }) {
    return ListsState(
      listsModels: listsModels ?? this.listsModels,
      status: status ?? this.status,
    );
  }

  @override
  String toString() => 'ListsState(listsModels: $listsModels, status: $status)';
}
