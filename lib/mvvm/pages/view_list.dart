import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_todo/mvvm/pages/row_item.dart';

import '../task_list_viewmodel.dart';
import '../task_model.dart';


class TaskViewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskViewModel('ownerUserId'),
      child: Scaffold(
        appBar: AppBar(
          title: Text('TODO App'),
        ),
        body: TaskListView(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Implement task creation dialog
            _showTaskCreationDialog(context);

          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
void _showTaskCreationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      TextEditingController titleController = TextEditingController();

      return AlertDialog(
        title: Text('Create New Task'),
        content: TextField(
          controller: titleController,
          decoration: InputDecoration(hintText: 'Task Title'),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                // Create a new task and add it to the ViewModel
                Task newTask = Task(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: titleController.text,
                  completed: false,
                  ownerId: 'ownerUserId', // Replace with actual owner ID
                  lastUpdated: DateTime.now(),
                );

                Provider.of<TaskViewModel>(context, listen: false).addTask(newTask);
                Navigator.of(context).pop(); // Close the dialog
              }
            },
            child: Text('Create'),
          ),
        ],
      );
    },
  );
}
class TaskListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(
      builder: (context, taskViewModel, child) {
        return ListView.builder(
          itemCount: taskViewModel.tasks.length,
          itemBuilder: (context, index) {
            Task task = taskViewModel.tasks[index];
            return TaskListItem(task: task);
          },
        );
      },
    );
  }
}


