// task_list_viewmodel.dart

import 'package:flutter/material.dart';
import 'package:task_todo/mvvm/services.dart';
import 'task_model.dart';

class TaskListViewModel with ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();

  Stream<List<Task>> getTasksStream() {
    return _firebaseService.getTasksStream();
  }

  Future<void> updateTaskName(String taskId, String newName) async {
    await _firebaseService.updateTaskName(taskId, newName);
  }

  Future<void> shareTask(String userEmail, String taskId) async {
    await _firebaseService.shareTask(userEmail, taskId);
  }
  Future<void> createTask(String taskName) async {
    String ownerId = _firebaseService.currentUser?.uid ?? 'unknown';

    await _firebaseService.tasksCollection.add({
      'name': taskName,
      'owner': ownerId,
      'sharedWith': <String>[],
    });
  }
}
