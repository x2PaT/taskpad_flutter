import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/tasks/tasks_cubit.dart';

Future<dynamic> newTaskBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return NewTaskBottomSheetContent();
    },
  );
}

class NewTaskBottomSheetContent extends StatefulWidget {
  const NewTaskBottomSheetContent({super.key});

  @override
  State<NewTaskBottomSheetContent> createState() => _NewTaskBottomSheetContentState();
}

class _NewTaskBottomSheetContentState extends State<NewTaskBottomSheetContent>
    with SingleTickerProviderStateMixin {
  late final TextEditingController titleController;
  late final AnimationController shakeAnimationController;

  @override
  void initState() {
    titleController = TextEditingController();

    shakeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    titleController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  dispose() {
    shakeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 12.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(shakeAnimationController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          shakeAnimationController.reverse();
        }
      });

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.all(12),
                  icon: Icon(Icons.close, size: 36),
                ),
                Text(
                  "Add task",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (titleController.value.text.isEmpty) {
                      shakeAnimationController.forward(from: 0.0);
                      return;
                    }

                    context.read<TasksCubit>().addTask(titleController.text);
                    Navigator.pop(context);
                  },
                  isSelected: titleController.text.isNotEmpty,
                  selectedIcon: Icon(
                    Icons.add,
                    size: 36,
                    color: Colors.black,
                  ),
                  padding: EdgeInsets.all(12),
                  icon: Icon(
                    Icons.add,
                    size: 36,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: AnimatedBuilder(
                animation: offsetAnimation,
                builder: (buildContext, child) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: offsetAnimation.value + 12.0, right: 12.0 - offsetAnimation.value),
                    child: Center(
                      child: TextField(
                        autofocus: true,
                        controller: titleController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "What do you mean?",
                          labelText: "Task",
                        ),
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
