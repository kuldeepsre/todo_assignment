import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:task_todo/task.dart';
import 'package:task_todo/widget/home_page.dart';

import 'TaskListViewModel.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter()); // Register the adapter
  await Hive.openBox<Task>('tasks');
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TaskListViewModel taskListViewModel = TaskListViewModel();
    taskListViewModel.listenForUpdates(); // Start listening for real-time updates
    return ChangeNotifierProvider(
      create: (context) => taskListViewModel,
      child: MaterialApp(
        title: 'Task Assignment',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: Dashboard(),
      ),
    );
  }
}