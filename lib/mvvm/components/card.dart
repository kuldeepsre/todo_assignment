import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../task_model.dart';
import 'custom_text_field.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final Function(String) onNameChanged;
  final Function(Task) onShare;

  TaskCard({required this.task, required this.onNameChanged, required this.onShare});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(task.name),
        subtitle: Text(task.owner),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _showEditDialog(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                onShare(task);
              },
            ),
          ],
        ),
      ),
    );
  }
  void _showEditDialog(BuildContext context) {
    TextEditingController _controller = TextEditingController(text: task.name);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: CustomTextField(
            hintText: 'New Task Name',
            controller: _controller,
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
                onNameChanged(_controller.text);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}