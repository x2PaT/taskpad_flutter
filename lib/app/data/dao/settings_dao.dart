
import '../../../models/setting_model.dart';
import '../base_dao_impl.dart';

class SettingsDao extends BaseDao<SettingModel> {
  SettingsDao(super.boxName);
  static const int darkModeKey = 22;
  static const int currentListKey = 22;

  dynamic getValueForKey(int key) {
    final setting = readObjectByKey(key);
    return setting?.value;
  }

  Future<void> setValueForKey(int key, dynamic value) async {
    final newSetting = SettingModel(key: key, value: value);
    await addObject(key, newSetting);
  }

  Stream<int?> readCurrentListID() {
    return readSingleObjectStream(key: currentListKey).map(
      (event) => event.value,
    );
  }

  int? readCurrentListIDValue() {
    return getValueForKey(currentListKey);
  }

  Future<void> writeCurrentListID(int newListId) async {
    await addObject(currentListKey, SettingModel(key: currentListKey, value: newListId));
  }
}
