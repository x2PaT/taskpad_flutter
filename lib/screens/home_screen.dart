import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/tasks/tasks_cubit.dart';
import 'home_screen_drawer.dart';
import 'list_loaded_widget.dart';
import 'new_list_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeScreenDrawer(),
      appBar: AppBar(
        title: const Text("TaskPad Flutter"),
      ),
      floatingActionButton: (context.watch<TasksCubit>().state is TasksStateListNotExist)
          ? FloatingActionButton(
              onPressed: () => newListBottomSheet(context),
              child: Icon(Icons.add),
            )
          : null,
      body: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          if (state is TasksStateLoading || state is TasksStateInitial) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "Data loading",
                    style: TextStyle(fontSize: 24),
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            );
          } else if (state is TasksStateLoaded) {
            return ListLoadedWidget(state: state);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
