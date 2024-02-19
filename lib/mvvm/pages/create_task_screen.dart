// create_task_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_text_field.dart';
import '../task_list_viewmodel.dart';


class CreateTaskScreen extends StatelessWidget {
  final TextEditingController _taskNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskListViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create Task'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomTextField(
                hintText: 'Task Name',
                controller: _taskNameController,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _createTask(context);
                },
                child: Text('Create Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createTask(BuildContext context) {
    TaskListViewModel model = Provider.of<TaskListViewModel>(context, listen: false);

    String taskName = _taskNameController.text;

    if (taskName.isNotEmpty) {
      model.createTask(taskName);
      Navigator.pop(context); // Close the create task screen
    }
  }
}
