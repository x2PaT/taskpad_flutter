import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskpad_flutter/app/enums/enums.dart';
import 'package:taskpad_flutter/cubit/lists/lists_cubit.dart';

class HomeScreenDrawer extends StatelessWidget {
  const HomeScreenDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListsCubit, ListsState>(
      builder: (context, state) {
        switch (state.status) {
          case Status.error:
          case Status.initial:
          case Status.loading:
            return Drawer();
          case Status.success:
            return Drawer(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.listsModels.length,
                      itemBuilder: (context, index) {
                        final item = state.listsModels[index];
                        return ListTile(
                          onTap: () {
                            context.read<ListsCubit>().changeCurrentList(item);
                            Navigator.pop(context);
                          },
                          title: Text(item.listName),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
        }
      },
    );
  }
}
