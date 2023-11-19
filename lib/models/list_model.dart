// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/hive_flutter.dart';

import '../app/constants/config.dart';

part 'list_model.g.dart';

@HiveType(typeId: Config.listModelTypeID)
class ListModel {
  ListModel({
    required this.listID,
    required this.listName,
    DateTime? creationDate,
  }) : creationDate = creationDate ?? DateTime.now();

  @HiveField(0)
  final int listID;
  @HiveField(1)
  final String listName;
  @HiveField(2)
  final DateTime creationDate;

  ListModel copyWith({
    int? listID,
    String? listName,
    DateTime? creationDate,
  }) {
    return ListModel(
      listID: listID ?? this.listID,
      listName: listName ?? this.listName,
      creationDate: creationDate ?? this.creationDate,
    );
  }

  @override
  String toString() =>
      'ListModel(listID: $listID, listName: $listName, creationDate: $creationDate)';
}
