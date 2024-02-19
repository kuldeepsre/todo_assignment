import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../task_model.dart';
import '../task_list_viewmodel.dart';

class TaskEditDialog extends StatefulWidget {
  final Task task;

  TaskEditDialog({required this.task});

  @override
  _TaskEditDialogState createState() => _TaskEditDialogState();
}

class _TaskEditDialogState extends State<TaskEditDialog> {
  late TextEditingController _titleController;
  late bool _completed;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _completed = widget.task.completed;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Task Title'),
          ),
          CheckboxListTile(
            title: Text('Completed'),
            value: _completed,
            onChanged: (value) {
              setState(() {
                _completed = value!;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Save the edited task
            Task editedTask = Task(
              id: widget.task.id,
              title: _titleController.text,
              completed: _completed,
              ownerId: widget.task.ownerId,
              lastUpdated: DateTime.now(),
            );

            // Call the updateTask method from the provider
            Provider.of<TaskViewModel>(context, listen: false).updateTask(editedTask);

            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
