// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'lists_cubit.dart';

class ListsState {
  ListsState({
    this.listsModels = const [],
    this.status = Status.initial,
  });
  
  final List<ListModel> listsModels;
  final Status status;

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
