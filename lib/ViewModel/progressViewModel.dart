import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProgressViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  int _completedTasksCount = 0;
  int get completedTasksCount => _completedTasksCount;

  Future<void> fetchCompletedTasksCount() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      User? user = _auth.currentUser;
      if (user == null) throw Exception("User not logged in");

      DocumentSnapshot userDoc =
      await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        _completedTasksCount = userDoc.get('completedTasksCount') ?? 0;
      } else {
        _completedTasksCount = 0;
      }
    } catch (e) {
      _error = 'Error loading completed tasks count: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
