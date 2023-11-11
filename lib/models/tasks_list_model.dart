import 'package:hive_flutter/hive_flutter.dart';

import '../app/constants/config.dart';

part 'tasks_list_model.g.dart';

@HiveType(typeId: Config.tasksListModelTypeID)
class ListModel {
  ListModel({
    required this.listID,
    this.listTasks = const [],
  });

  @HiveField(0)
  final int listID;
  @HiveField(1)
  final List<int> listTasks;

  ListModel copyWith({
    int? listID,
    List<int>? listTasks,
  }) {
    return ListModel(
      listID: listID ?? this.listID,
      listTasks: listTasks ?? this.listTasks,
    );
  }

  @override
  String toString() => 'TasksListModel(listID: $listID, listTasks: $listTasks)';
}
