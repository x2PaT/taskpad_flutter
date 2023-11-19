import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskpad_flutter/cubit/cubit/tasks_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          return Column(
            children: [
              SizedBox(
                height: 100,
                child: ListView.builder(
                  itemCount: state.lists.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final item = state.lists[index];
                    return ElevatedButton(
                      onPressed: () {
                        context.read<TasksCubit>().changeCurrentList(item.listID);
                      },
                      child: Text(item.listName),
                    );
                  },
                ),
              ),
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
