import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_todo/mvvm/task_model.dart';
import 'package:url_launcher/url_launcher.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Task>> getTasksStream(String ownerId) {
    return _firestore
        .collection('tasks')
        .where('ownerId', isEqualTo: ownerId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Task(
          id: doc.id,
          title: doc['title'],
          completed: doc['completed'],
          ownerId: doc['ownerId'],
          lastUpdated: (doc['lastUpdated'] as Timestamp?)?.toDate() ?? DateTime.now(),

        );
      }).toList();
    });
  }

  Future<void> addTask(Task task) async {
    await _firestore.collection('tasks').add({
      'title': task.title,
      'completed': task.completed,
      'ownerId': task.ownerId,
      'lastUpdated': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateTask(Task task) async {
    await _firestore.collection('tasks').doc(task.id).update({
      'title': task.title,
      'completed': task.completed,
      'lastUpdated': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteTask(String taskId) async {
    await _firestore.collection('tasks').doc(taskId).delete();
  }

  Future<void> shareTaskViaEmail(Task task) async {
    final String taskDetails = "Task: ${task.title}\nStatus: ${task.completed ? 'Completed' : 'Pending'}";

    // Use the url_launcher package to launch the email client
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: '', // Empty path opens the default email client
      queryParameters: {
        'subject': 'Task Details',
        'body': taskDetails,
      },
    );

    // Launch the email client
    if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    } else {
      // Handle the exception if the URL can't be launched
      print('Could not launch email');
    }
  }
}
