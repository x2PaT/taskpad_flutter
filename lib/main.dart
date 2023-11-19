import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskpad_flutter/cubit/cubit/tasks_cubit.dart';
import 'app/app.dart';
import 'app/app_service.dart';
import 'app/di/di_service.dart';

void main() async {
  await AppService.instance.init();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider.value(value: DiService.getIt<TasksCubit>()),
    ],
    child: const MyApp(),
  ));
}
