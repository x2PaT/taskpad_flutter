import 'package:hive_flutter/hive_flutter.dart';

import '../app/constants/config.dart';

part 'list_model.g.dart';

@HiveType(typeId: Config.listModelTypeID)
class ListModel {
  ListModel({
    required this.listID,
    required this.listName,
    this.listTasks = const [],
    DateTime? creationDate,
  }) : creationDate = creationDate ?? DateTime.now();

  @HiveField(0)
  final int listID;
  @HiveField(1)
  final String listName;
  @HiveField(2)
  final List<int> listTasks;
  @HiveField(3)
  final DateTime creationDate;

  ListModel copyWith({
    int? listID,
    String? listName,
    List<int>? listTasks,
    DateTime? creationDate,
  }) {
    return ListModel(
      listID: listID ?? this.listID,
      listName: listName ?? this.listName,
      listTasks: listTasks ?? this.listTasks,
      creationDate: creationDate ?? this.creationDate,
    );
  }

  @override
  String toString() {
    return 'ListModel(listID: $listID, listName: $listName, listTasks: $listTasks, creationDate: $creationDate)';
  }
}
