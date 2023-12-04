import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskpad_flutter/cubit/lists/lists_cubit.dart';

import '../cubit/tasks/tasks_cubit.dart';
import 'home_screen_drawer.dart';

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
                  child: Row(children: [
                    IconButton(
                      padding: EdgeInsets.all(14),
                      iconSize: 32,
                      onPressed: () {
                        context.read<ListsCubit>().changeToPrevList(currentList: state.currentList);
                      },
                      icon: Icon(Icons.arrow_back_rounded),
                      color: Colors.lightBlueAccent,
                    ),
                    Text(state.currentList.listName),
                    IconButton(
                      padding: EdgeInsets.all(14),
                      iconSize: 32,
                      onPressed: () {
                        context.read<ListsCubit>().changeToNextList(currentList: state.currentList);
                      },
                      icon: Icon(Icons.arrow_forward_rounded),
                      color: Colors.lightBlueAccent,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context.read<TasksCubit>().addTask();
                        },
                        child: Text("Add task"))
                  ]),
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
