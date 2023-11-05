import 'package:hive_flutter/hive_flutter.dart';

import 'base_dao_interface.dart';

abstract class BaseDao<T> implements IBaseDao<T> {
  late Box<T> _box;
  late String boxName;

  BaseDao(this.boxName);

  @override
  Future<void> initBox() async {
    await Hive.openBox<T>(boxName);
    _box = Hive.box<T>(boxName);
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
}
