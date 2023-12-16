import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskpad_flutter/cubit/lists/lists_cubit.dart';
import 'app/app.dart';
import 'app/app_service.dart';
import 'app/di/di_service.dart';
import 'cubit/tasks/tasks_cubit.dart';

void main() async {
  await AppService.instance.init();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider.value(value: DiService.get<TasksCubit>()),
      BlocProvider.value(value: DiService.get<ListsCubit>()),
    ],
    child: const MyApp(),
  ));
}
