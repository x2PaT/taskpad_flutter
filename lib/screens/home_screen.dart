import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = "/main_screen_route";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TaskPad Flutter"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      drawer: const Drawer(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
