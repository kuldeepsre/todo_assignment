// firebase_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_todo/mvvm/task_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signInAnonymously() async {
    await _auth.signInAnonymously();
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  CollectionReference get tasksCollection => _firestore.collection('tasks');

  Stream<List<Task>> getTasksStream() {
    return tasksCollection
        .where('owner', isEqualTo: currentUser?.uid)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Task(
          id: doc.id,
          name: doc['name'],
          owner: doc['owner'],
          sharedWith: List<String>.from(doc['sharedWith']),
        );
      }).toList();
    });
  }

  Future<void> updateTaskName(String taskId, String newName) async {
    await tasksCollection.doc(taskId).update({'name': newName});
  }

  Future<void> shareTask(String userEmail, String taskId) async {
    QuerySnapshot querySnapshot =
    await _firestore.collection('users').where('email', isEqualTo: userEmail).get();

    if (querySnapshot.docs.isNotEmpty) {
      String sharedUserId = querySnapshot.docs.first.id;

      await tasksCollection.doc(taskId).update({
        'sharedWith': FieldValue.arrayUnion([sharedUserId]),
      });
    }
  }

}
