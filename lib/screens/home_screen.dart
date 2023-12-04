import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../cubit/cubit/tasks_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = "/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                ListTile();
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("TaskPad Flutter"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          context.read<TasksCubit>().addTask();
        },
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
