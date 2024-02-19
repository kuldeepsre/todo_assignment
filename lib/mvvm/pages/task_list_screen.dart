import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/card.dart';
import '../components/custom_text_field.dart';
import '../task_list_viewmodel.dart';
import '../task_model.dart';
import 'create_task_screen.dart';


class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskListViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Task List'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _navigateToCreateTask(context);
              },
            ),
          ],
        ),
        body: _buildTaskList(),
      ),
    );
  }

  Widget _buildTaskList() {
    return Consumer<TaskListViewModel>(
      builder: (context, model, child) {
        return StreamBuilder<List<Task>>(
          stream: model.getTasksStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

            List<Task> tasks = snapshot.data!;

            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                Task task = tasks[index];
                return TaskCard(
                  task: task,
                  onNameChanged: (newName) {
                    model.updateTaskName(task.id, newName);
                  },
                  onShare: (task) {
                    _showShareDialog(context, model, task);
                  },
                );
              },
            );
          },
        );
      },
    );
  }


  void _showShareDialog(BuildContext context, TaskListViewModel model, Task task) {
    TextEditingController _emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Share Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Enter the email of the user you want to share this task with:'),
              SizedBox(height: 8.0),
              CustomTextField(
                hintText: 'User Email',
                controller: _emailController,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String userEmail = _emailController.text;
                if (userEmail.isNotEmpty) {
                  model.shareTask(userEmail, task.id);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Share'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToCreateTask(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateTaskScreen()),
    );
  }
}