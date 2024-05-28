import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunny_childhood/model/lesson_model.dart';
import 'package:uuid/uuid.dart';

class Firestore_Datasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List getNotes(AsyncSnapshot snapshot) {
    try {
      final notesList = snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Lesson(
          data['id'],
          data['subtitle'],
          data['time'],
          data['image'],
          data['title'],
          data['isDon'],
        );
      }).toList();
      return notesList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<String?> getInstructionText() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('app_info').doc('instructions').get();
      if (snapshot.exists) {
        return snapshot.data()?['text'];
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching instruction text: $e');
      return null;
    }
  }
}
