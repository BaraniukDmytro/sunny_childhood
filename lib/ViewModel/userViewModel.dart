import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createUser(String email, String avatarUrl) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({
        "id": _auth.currentUser!.uid,
        "email": email,
        "avatarUrl": avatarUrl,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<String?> getUserEmail() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        return user.email;
      } else {
        return null;
      }
    } catch (e) {
      print("Error getting email: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore.collection('users').doc(userId).get();
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data()!;
        return userData;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }
}

