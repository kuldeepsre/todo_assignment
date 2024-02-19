import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:share/share.dart';
import 'package:task_todo/task.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TaskListViewModel extends ChangeNotifier {
  late Box<Task> _tasksBox;
  late WebSocketChannel _channel;

  TaskListViewModel() {
    _tasksBox = Hive.box<Task>('tasks');
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://your-realtime-server.com'), // Replace with your server address
    );
  }

  List<Task> get tasks => _tasksBox.values.toList();

  void addTask(Task task) {
    _tasksBox.add(task);
    _channel.sink.add(jsonEncode({'action': 'addTask', 'task': task}));
    notifyListeners();
  }

  void shareTask(BuildContext context, Task task) {
    Share.share('Task: ${task.title}');
  }

  void listenForUpdates() {
    _channel.stream.listen((data) {
      Map<String, dynamic> decodedData = jsonDecode(data);
      String action = decodedData['action'];
      if (action == 'updateTask') {
        Task updatedTask = Task(decodedData['task']['title'], decodedData['task']['isShared']);
        _updateLocalTask(updatedTask);
      }
    });
  }

  void _updateLocalTask(Task updatedTask) {
    int index = _tasksBox.values.toList().indexWhere((task) => task.title == updatedTask.title);
    if (index != -1) {
      _tasksBox.putAt(index, updatedTask);
      notifyListeners();
    }
  }
}