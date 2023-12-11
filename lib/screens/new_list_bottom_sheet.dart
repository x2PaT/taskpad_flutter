import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskpad_flutter/cubit/lists/lists_cubit.dart';

Future<dynamic> newListBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return NewListBottomSheetContent();
      });
}

class NewListBottomSheetContent extends StatefulWidget {
  const NewListBottomSheetContent({super.key});

  @override
  State<NewListBottomSheetContent> createState() => _NewListBottomSheetContentState();
}

class _NewListBottomSheetContentState extends State<NewListBottomSheetContent>
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
                  "New list",
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

                    context.read<ListsCubit>().addList(titleController.text);
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
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Start storing things",
                          labelText: "List name",
                        ),
                        onChanged: (value) {
                          setState(() {
                            titleController.text = value;
                          });
                        },
                        controller: titleController,
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
