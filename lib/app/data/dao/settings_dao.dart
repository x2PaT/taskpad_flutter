import 'package:taskpad_flutter/app/constants/config.dart';

import '../../../models/setting_model.dart';
import '../base_dao_impl.dart';

class SettingsDao extends BaseDao<SettingModel> {
  SettingsDao(super.boxName);
  static const int darkModeKey = 22;

  dynamic getValueForKey(int key) {
    final setting = readObjectByKey(key);
    return setting?.value;
  }

  Future<void> setValueForKey(int key, dynamic value) async {
    final newSetting = SettingModel(key: key, value: value);
    await addObject(key, newSetting);
  }
}

Future<SettingsDao> getSettingsDao() async {
  final settingsDao = SettingsDao(Config.settingsBoxName);
  await settingsDao.initBox();
  return settingsDao;
}
