import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../const/colors.dart';
import '../menu.dart';
import '../screen/news_screen.dart';
import 'auth_page.dart';

class UsersPage extends StatelessWidget{
  const UsersPage({super.key});

  @override
  Widget build( BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Volunteers"),
        backgroundColor: custom_green,
        elevation: 0,
      ),
      drawer: AppMenu(),

      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return NewsScreen();
          } else {
            return Auth_Page();
          }
          },
      ),
    );
  }
}