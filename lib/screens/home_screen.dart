import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/cubit/tasks_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = "/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeScreenDrawer(),
      appBar: AppBar(
        title: const Text("TaskPad Flutter"),
        actions: [
          IconButton(
              onPressed: () => context.read<TasksCubit>().showPrevList(),
              icon: Icon(Icons.arrow_circle_left_rounded)),
          IconButton(
              onPressed: () => context.read<TasksCubit>().showNextList(),
              icon: Icon(Icons.arrow_circle_right)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          context.read<TasksCubit>().addTask();
        },
      ),
      body: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
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
        },
      ),
    );
  }
}

class HomeScreenDrawer extends StatelessWidget {
  const HomeScreenDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final lists = context.watch<TasksCubit>().state.lists;

    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: lists.length,
              itemBuilder: (context, index) {
                final item = lists[index];
                return ElevatedButton(
                  onPressed: () {
                    context.read<TasksCubit>().changeCurrentList(item.listID);
                    Navigator.pop(context);
                  },
                  child: Text(item.listName),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
