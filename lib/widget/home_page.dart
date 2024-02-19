import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../TaskListViewModel.dart';
import '../component/input_filed.dart';
import '../pages/InfiniteTaskListView.dart';
import '../task.dart';

class Dashboard extends StatelessWidget {
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' Task Assignment'),
      ),
      body: Column(
        children: [
          InputField(controller: _taskController),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () {
              TaskListViewModel taskListViewModel =
              Provider.of<TaskListViewModel>(context, listen: false);
              taskListViewModel.addTask(Task(_taskController.text, false));
            },
            child: const Text('Add Task'),
          ),
          Expanded(
            child: InfiniteTaskListView(),
          ),
        ],
      ),
    );
  }
}