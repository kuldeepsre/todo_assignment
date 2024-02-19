import 'package:flutter/material.dart';
import 'package:task_todo/mvvm/services.dart';
import 'package:task_todo/mvvm/task_model.dart';


class TaskViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  TaskViewModel(String ownerId) {
    _firebaseService.getTasksStream(ownerId).listen((tasks) {
      _tasks = tasks;
      notifyListeners();
    });
  }

  void addTask(Task task) {
    _firebaseService.addTask(Task(
      id: task.id,
      title: task.title,
      completed: task.completed,
      ownerId: task.ownerId,
      lastUpdated: DateTime.now(),
    ));
  }

  void updateTask(Task task) {
    _firebaseService.updateTask(task);
  }

  void deleteTask(String taskId) {
    _firebaseService.deleteTask(taskId);
  }
}
