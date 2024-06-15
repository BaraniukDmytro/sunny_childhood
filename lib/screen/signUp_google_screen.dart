import 'package:flutter/material.dart';
import 'package:sunny_childhood/repository/auth_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpGoogleScreen extends StatefulWidget {
  const SignUpGoogleScreen({Key? key}) : super(key: key);

  @override
  _SignUpGoogleScreenState createState() => _SignUpGoogleScreenState();
}

class _SignUpGoogleScreenState extends State<SignUpGoogleScreen> {
  bool _isSigningIn = false;

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    final googleSignIn = GoogleSignIn();
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut();
    }
  }

  Future<void> _signUpWithGoogle(BuildContext context) async {
    setState(() {
      _isSigningIn = true;
    });

    await _signOut();  // Додаємо вихід перед новим входом

    final user = await AuthenticationRemote().signInWithGoogle();
    if (user != null) {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Помилка входу за допомогою Google')),
        );
      }
    }

    if (mounted) {
      setState(() {
        _isSigningIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Вхід за допомогою Google')),
      body: Center(
        child: _isSigningIn
            ? CircularProgressIndicator()
            : ElevatedButton(
          onPressed: () => _signUpWithGoogle(context),
          child: Text('Вхід'),
        ),
      ),
    );
  }
}
