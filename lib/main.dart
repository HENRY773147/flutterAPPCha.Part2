import 'package:flutter/material.dart';
import 'package:flutter_app_cha/controllers/task_controller.dart';
import 'package:flutter_app_cha/views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a shared instance of TaskController
    final taskController = TaskController();

    return MaterialApp(
      title: 'Student Task Manager',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      home: HomePage(taskController: taskController),
      debugShowCheckedModeBanner: false,
    );
  }
}
