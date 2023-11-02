abstract class IBaseDao<T> {
  Future<void> initBox();
  Future<void> addObject(int key, T object);
  Future<List<T>> getAllObjects();
  Future<void> deleteObject(int key);
  T? readObjectByKey(int key);
}
