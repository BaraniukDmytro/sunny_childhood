import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthenticationDatasource {
  Future<void> register(String email, String password, String passwordConfirm, String name, String age, String additionalInfo, String avatarUrl);
  Future<void> login(String email, String password);
}

class AuthenticationRemote extends AuthenticationDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print('Failed to sign in with Email & Password: $e');
      rethrow;
    } catch (e) {
      print('An error occurred while signing in: $e');
      rethrow;
    }
  }

  @override
  Future<void> register(String email, String password, String passwordConfirm, String name, String age, String additionalInfo, String avatarUrl) async {
    if (passwordConfirm != password) {
      throw Exception('Passwords do not match');
    }

    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      ).then((value) async {
        await _firestore.collection('users').doc(value.user!.uid).set({
          'email': email,
          'name': name,
          'age': age,
          'additionalInfo': additionalInfo,
          'avatarUrl': avatarUrl, // Збереження вибраного аватара
        });
      });
    } on FirebaseAuthException catch (e) {
      print('Failed to register with Email & Password: $e');
      rethrow;
    } catch (e) {
      print('An error occurred while registering: $e');
      rethrow;
    }
  }
}

