import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:task_todo/pages/task_list.dart';

import '../TaskListViewModel.dart';
import '../task.dart';

class InfiniteTaskListView extends StatelessWidget {
  const InfiniteTaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (notification) {
        // Load more tasks when reaching the end of the list
        TaskListViewModel taskListViewModel =
        Provider.of<TaskListViewModel>(context, listen: false);
        taskListViewModel.addTask(Task('New Task', false));
        return true;
      },
      child: TaskListView(),
    );
  }
}