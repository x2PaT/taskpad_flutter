import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'base_dao_interface.dart';

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
    final object = _box.get(key);

    return object;
  }

  @override
  void deleteAll(List<int> keys) {
    _box.deleteAll(keys);
  }

  @override
  ValueListenable<Box<T>> listenable({List<dynamic>? keys}) {
    return _box.listenable(keys: keys);
  }
}
