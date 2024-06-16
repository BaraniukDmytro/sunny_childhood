import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sunny_childhood/model/lesson_model.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

class LessonViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> addNote(String subtitle, String title, int image) async {
    try {
      var uuid = Uuid().v4();
      DateTime data = DateTime.now();
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('lessons')
          .doc(uuid)
          .set({
        'id': uuid,
        'subtitle': subtitle,
        'isDon': false,
        'image': image,
        'time': '${data.hour}:${data.minute}',
        'title': title,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<QuerySnapshot> stream(bool isDone) {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('lessons')
        .where('isDon', isEqualTo: isDone)
        .snapshots();
  }

  Future<bool> updateNote(
      String uuid, int image, String title, String subtitle) async {
    try {
      DateTime data = DateTime.now();
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('lessons')
          .doc(uuid)
          .update({
        'time': '${data.hour}:${data.minute}',
        'subtitle': subtitle,
        'title': title,
        'image': image,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteNote(String uuid) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('lessons')
          .doc(uuid)
          .delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> setIsDone(String uuid, bool isDone) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) return false;

      DocumentReference userDoc = _firestore.collection('users').doc(user.uid);
      DocumentReference lessonDoc = userDoc.collection('lessons').doc(uuid);

      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot lessonSnapshot = await transaction.get(lessonDoc);
        if (!lessonSnapshot.exists) return;

        transaction.update(lessonDoc, {'isDon': isDone});
        transaction.update(userDoc, {
          'completedTasksCount': FieldValue.increment(isDone ? 1 : -1),
        });
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<int> getCompletedTasksCount() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) return 0;

      DocumentSnapshot userDoc =
      await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        return userDoc.get('completedTasksCount') ?? 0;
      } else {
        return 0;
      }
    } catch (e) {
      print('Error loading completed tasks count: $e');
      return 0;
    }
  }
}

