abstract class IBaseDao<T> {
  Future<void> initBox();
  Future<void> clearBox();
  Future<void> addObject(int key, T object);
  List<T> getAllObjects();
  Future<void> deleteObject(int key);
  T? readObjectByKey(int key);
  Stream<List<T>> readObjectsStream({List<int>? keys});
}
