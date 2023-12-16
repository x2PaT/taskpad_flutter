import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class IBaseDao<T> {
  Future<void> initBox();
  Future<void> clearBox();
  Future<void> addObject(int key, T object);
  List<T> getAllObjects();
  Future<void> deleteObject(int key);
  void deleteAll(List<int> keys);
  T? readObjectByKey(int key);
  ValueListenable<Box<T>> listenable({List<dynamic>? keys});
}
