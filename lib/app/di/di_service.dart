import 'package:get_it/get_it.dart';
import 'package:taskpad_flutter/app/constants/config.dart';
import 'package:taskpad_flutter/app/data/dao/settings_dao.dart';
import 'package:taskpad_flutter/app/data/dao/task_dao.dart';
import 'package:taskpad_flutter/app/data/dao/tasks_list_dao.dart';
import 'package:taskpad_flutter/cubit/cubit/tasks_cubit.dart';
import 'package:taskpad_flutter/repository/lists_repository_impl.dart';
import 'package:taskpad_flutter/repository/lists_repository_interface.dart';
import 'package:taskpad_flutter/repository/tasks_repository_impl.dart';
import 'package:taskpad_flutter/repository/tasks_repository_interface.dart';

class DiService {
  DiService._();

  static final DiService instance = DiService._();

  static final getIt = GetIt.instance;

  void init() {
//bloc

    getIt.registerFactory(() => TasksCubit(listsRepository: getIt(), tasksRepository: getIt()));

//repository
    getIt.registerLazySingleton<IListsRepository>(() => ListsRepository(
          listDao: getIt(),
          settingsDao: getIt(),
        ));

    getIt.registerLazySingleton<ITasksRepository>(() => TasksRepository(
          taskDao: getIt(),
          settingsDao: getIt(),
          listDao: getIt(),
        ));

//datasource
    getIt.registerLazySingleton(() => TaskDao(Config.tasksBoxName));
    getIt.registerLazySingleton(() => ListDao(Config.listsBoxName));
    getIt.registerLazySingleton(() => SettingsDao(Config.settingsBoxName));
  }
}
