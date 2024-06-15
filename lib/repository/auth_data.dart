import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticationDatasource {
  Future<void> register(String email, String password, String passwordConfirm, String name, String age, String additionalInfo, String avatarUrl);
  Future<void> login(String email, String password);
  Future<User?> signInWithGoogle();  // Додаємо метод для Google
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

  Future<User?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return null; // Якщо користувач скасував вхід
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final userDoc = _firestore.collection('users').doc(user.uid);
        final userSnapshot = await userDoc.get();

        if (!userSnapshot.exists) {
          await userDoc.set({
            'email': user.email,
            'name': user.displayName,
            // Додаткові поля можна додати тут
          });
        }
      }

      return user;
    } catch (e) {
      print('Error during Google sign-in: $e');
      return null;
    }
  }

}



