import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskpad_flutter/cubit/lists/lists_cubit.dart';

import '../cubit/tasks/tasks_cubit.dart';
import 'home_screen_drawer.dart';
import 'new_task_bottom_sheet.dart';

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
          }
          if (state is TasksStateLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) {
                      final item = state.tasks[index];

                      return ListTile(
                        title: Text(
                          item.taskText,
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            await context.read<TasksCubit>().deleteTask(item.taskId);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      IconButton(
                          padding: EdgeInsets.all(14),
                          iconSize: 32,
                          onPressed: () {
                            context
                                .read<ListsCubit>()
                                .changeToPrevList(currentList: state.currentList);
                          },
                          icon: Icon(Icons.arrow_back_rounded),
                          color: Color(
                              context.read<ListsCubit>().state.isPrevList(state.currentList)
                                  ? 0xFF40C4FF
                                  : 0x20000000)),
                      Expanded(
                        child: Text(
                          state.currentList.listName,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                          padding: EdgeInsets.all(14),
                          iconSize: 32,
                          onPressed: () {
                            context
                                .read<ListsCubit>()
                                .changeToNextList(currentList: state.currentList);
                          },
                          icon: Icon(Icons.arrow_forward_rounded),
                          color: Color(
                              context.read<ListsCubit>().state.isNextList(state.currentList)
                                  ? 0xFF40C4FF
                                  : 0x20000000)),
                      ElevatedButton(
                          onPressed: () {
                            newTaskBottomSheet(context);
                          },
                          child: Text("Add task"))
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
