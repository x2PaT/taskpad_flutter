import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskpad_flutter/cubit/lists/lists_cubit.dart';

import '../cubit/tasks/tasks_cubit.dart';
import 'new_task_bottom_sheet.dart';

class ListLoadedWidget extends StatelessWidget {
  const ListLoadedWidget({super.key, required this.state});

  final TasksStateLoaded state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (state.tasks.isEmpty)
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  width: 180,
                  height: 200,
                  child: SvgPicture.asset(
                    'assets/svg/empty_list.svg',
                    semanticsLabel: 'Empty list image',
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  "You don't have added any task yet",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        else
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
        Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              IconButton(
                  padding: EdgeInsets.all(14),
                  iconSize: 32,
                  onPressed: () {
                    context.read<ListsCubit>().changeToPrevList(currentList: state.currentList);
                  },
                  icon: Icon(Icons.arrow_back_rounded),
                  color: Color(context.read<ListsCubit>().state.isPrevList(state.currentList)
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
                    context.read<ListsCubit>().changeToNextList(currentList: state.currentList);
                  },
                  icon: Icon(Icons.arrow_forward_rounded),
                  color: Color(context.read<ListsCubit>().state.isNextList(state.currentList)
                      ? 0xFF40C4FF
                      : 0x20000000)),
              ElevatedButton(
                  onPressed: () => newTaskBottomSheet(context),
                  onLongPress: () => context.read<TasksCubit>().addTaskGen(),
                  child: Text("Add task"))
            ],
          ),
        ),
      ],
    );
  }
}
