// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TasksListModelAdapter extends TypeAdapter<ListModel> {
  @override
  final int typeId = 41;

  @override
  ListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListModel(
      listID: fields[0] as int,
      listTasks: (fields[1] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, ListModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.listID)
      ..writeByte(1)
      ..write(obj.listTasks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TasksListModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
