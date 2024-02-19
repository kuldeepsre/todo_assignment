import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../TaskListViewModel.dart';
import '../task.dart';

class TaskListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TaskListViewModel taskListViewModel =
    Provider.of<TaskListViewModel>(context);

    return ListView.builder(
      itemCount: taskListViewModel.tasks.length,
      itemBuilder: (context, index) {
        Task task = taskListViewModel.tasks[index];
        return ListTile(
          title: Text(task.title),
          trailing: IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              taskListViewModel.shareTask(context, task);
            },
          ),
        );
      },
    );
  }
}