import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Task> get tasks => _tasks;

  String? get _userId => FirebaseAuth.instance.currentUser?.uid;

  /// Load tasks from Firestore for the current user
  Future<void> loadTasks() async {
    if (_userId == null) return;

    final snapshot = await _firestore
        .collection('users')
        .doc(_userId)
        .collection('tasks')
        .get();

    _tasks = snapshot.docs.map((doc) {
      final data = doc.data();
      return Task(
        id: doc.id,
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        dueDate: DateTime.tryParse(data['dueDate'] ?? '') ?? DateTime.now(),
        isCompleted: data['isCompleted'] ?? false,
      );
    }).toList();

    notifyListeners();
  }

  /// Add a task to Firestore and memory
  Future<void> addTask(Task task) async {
    if (_userId == null) return;

    final docRef = await _firestore
        .collection('users')
        .doc(_userId)
        .collection('tasks')
        .add({
      'title': task.title,
      'description': task.description,
      'dueDate': task.dueDate.toIso8601String(),
      'isCompleted': task.isCompleted,
    });

    task.id = docRef.id;
    _tasks.add(task);
    notifyListeners();
  }

  /// Update an existing task
  Future<void> updateTask(Task task) async {
    if (_userId == null || task.id.isEmpty) return;

    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('tasks')
        .doc(task.id)
        .update({
      'title': task.title,
      'description': task.description,
      'dueDate': task.dueDate.toIso8601String(),
      'isCompleted': task.isCompleted,
    });

    int index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      notifyListeners();
    }
  }

  /// Delete a task
  Future<void> deleteTask(String id) async {
    if (_userId == null) return;

    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('tasks')
        .doc(id)
        .delete();

    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  /// Toggle task completion
  Future<void> toggleComplete(String id) async {
    if (_userId == null) return;

    final task = _tasks.firstWhere((t) => t.id == id);
    task.isCompleted = !task.isCompleted;

    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('tasks')
        .doc(id)
        .update({'isCompleted': task.isCompleted});

    notifyListeners();
  }

  /// Filter tasks by search term (for search bar)
  List<Task> searchTasks(String query) {
    if (query.isEmpty) return _tasks;

    return _tasks
        .where((t) =>
            t.title.toLowerCase().contains(query.toLowerCase()) ||
            t.description.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
