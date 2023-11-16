import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';

import 'base_dao_interface.dart';
import 'dao/helpers/value_listenable_to_stream_adapter.dart';

abstract class BaseDao<T> implements IBaseDao<T> {
  late Box<T> _box;
  late String boxName;

  BaseDao(this.boxName) {
    _box = Hive.box<T>(boxName);
  }

  @override
  Future<void> initBox() async {
    await Hive.openBox<T>(boxName);
    _box = Hive.box<T>(boxName);
  }

  @override
  Future<void> clearBox() async {
    await _box.clear();
  }

  @override
  Future<void> addObject(int key, T object) async {
    await _box.put(key, object);
  }

  @override
  List<T> getAllObjects() {
    return _box.values.toList();
  }

  @override
  Future<void> deleteObject(int key) async {
    await _box.delete(key);
  }

  @override
  T? readObjectByKey(int key) {
    return _box.get(key);
  }

  @override
  Stream<T> readSingleObjectStream({required int key}) {
    return _box.listenable(keys: [key]).toStream().map(
          (event) => event.values.first,
        );
  }

  @override
  Stream<List<T>> readObjectsStream({List<int>? keys}) {
    return _box.listenable(keys: keys).toStream().map(
          (event) => event.values.toList(),
        );
  }
}
