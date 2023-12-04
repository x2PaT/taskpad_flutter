import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskpad_flutter/app/data/dao/settings_dao.dart';
import 'package:taskpad_flutter/models/list_model.dart';

import '../../app/constants/config.dart';
import '../../app/enums/enums.dart';
import '../../models/setting_model.dart';

part 'lists_state.dart';

class ListsCubit extends Cubit<ListsState> {
  ListsCubit() : super(ListsState()) {
    start();
  }

  final Box<ListModel> listBox = Hive.box<ListModel>(Config.listsBoxName);

  final Box<SettingModel> settingsBox = Hive.box<SettingModel>(Config.settingsBoxName);

  void start() {
    emit(ListsState(status: Status.loading));

    final data = listBox.values.toList();

    emit(ListsState(listsModels: data));
  }

  changeCurrentList(ListModel item) {
    settingsBox.put(SettingsDao.currentListKey,
        SettingModel(key: SettingsDao.currentListKey, value: item.listID));
  }
}
