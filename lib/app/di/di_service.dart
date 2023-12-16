import 'package:get_it/get_it.dart';
import 'package:taskpad_flutter/app/constants/config.dart';
import 'package:taskpad_flutter/app/data/dao/settings_dao.dart';
import 'package:taskpad_flutter/app/data/dao/task_dao.dart';
import 'package:taskpad_flutter/app/data/dao/tasks_list_dao.dart';
import 'package:taskpad_flutter/cubit/lists/lists_cubit.dart';
import 'package:taskpad_flutter/repository/lists_repository_impl.dart';
import 'package:taskpad_flutter/repository/lists_repository_interface.dart';
import 'package:taskpad_flutter/repository/tasks_repository_impl.dart';
import 'package:taskpad_flutter/repository/tasks_repository_interface.dart';

import '../../cubit/tasks/tasks_cubit.dart';

class DiService {
  DiService._();

  static final DiService instance = DiService._();

  static final get = GetIt.instance;

  void init() {
//bloc
    get.registerFactory(() => ListsCubit(listsRepository: get(), tasksRepository: get()));

    get.registerFactory(() => TasksCubit(
          listsRepository: get(),
          tasksRepository: get(),
        ));

//repository
    get.registerLazySingleton<IListsRepository>(
        () => ListsRepository(listDao: get(), settingsDao: get(), taskDao: get()));

    get.registerLazySingleton<ITasksRepository>(() => TasksRepository(
          taskDao: get(),
          settingsDao: get(),
          listDao: get(),
        ));

//datasource
    get.registerLazySingleton(() => TaskDao(Config.tasksBoxName));
    get.registerLazySingleton(() => ListDao(Config.listsBoxName));
    get.registerLazySingleton(() => SettingsDao(Config.settingsBoxName));
  }
}
