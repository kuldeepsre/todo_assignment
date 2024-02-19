import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_todo/mvvm/pages/update_widget.dart';
import '../../utils/colors.dart';
import '../task_list_viewmodel.dart';
import '../task_model.dart';
import 'package:share/share.dart';


class TaskListItem extends StatelessWidget {
  final Task task;

  TaskListItem({required this.task});

  @override
  Widget build(BuildContext context) {
    Color taskColor = AppColors.blueShadeColor;
    return  Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 5.0,
            offset: Offset(0, 5), // shadow direction: bottom right
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 20,
          height: 20,
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          alignment: Alignment.center,
          child: CircleAvatar(
            backgroundColor: taskColor,
          ),
        ),
        title: Text(task.title??""),
/*
        subtitle: Text(data['taskDesc']??""),
*/
     
        trailing: PopupMenuButton(
          itemBuilder: (context) {
            return [

              const PopupMenuItem(
                value: 'share',

                child: Text(
                  'Share',
                  style: TextStyle(fontSize: 18.0),
                ),

              ),
              const   PopupMenuItem(
                value: 'edit',
                child:  Text(
                  'Edit',
                  style: TextStyle(fontSize: 18.0),
                ),

              ),
              const  PopupMenuItem(
                value: 'delete',
                child:  Text(
                  'Delete',
                  style: TextStyle(fontSize: 18.0),
                ),

              ),
            ];
          },

          onSelected: (String value) {
            if (value == 'share') {
              _showShareOptions(context, task);
            } else if (value == 'edit') {
              _showEditDialog(context, task);
            } else if (value == 'delete') {
              deleteTask(context, task);
            }
          },


        ),
        dense: true,
      ),
    );



  }
  void _showEditDialog(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TaskEditDialog(task: task);
      },
    );
  }
  void deleteTask(BuildContext context, Task task) {
    // Show a confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Task'),
        content: Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Call the deleteTask method from the provider
              Provider.of<TaskViewModel>(context, listen: false).deleteTask(task.id);
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showShareOptions(BuildContext context, Task task) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Share via Email'),
              onTap: () {
                Navigator.pop(context); // Close the bottom sheet
                _shareViaEmail(context, task);
              },
            ),
            // Add more share options here (e.g., social media)
          ],
        );
      },
    );
  }

  void _shareViaEmail(BuildContext context, Task task) {
    final String taskDetails = "Task: ${task.title}\nStatus: ${task.completed ? 'Completed' : 'Pending'}";

    // Use the share package to share the task details via email
    Share.share(taskDetails, subject: "Task Details - ${task.title}");
  }
}