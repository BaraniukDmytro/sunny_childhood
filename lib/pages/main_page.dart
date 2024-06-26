import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sunny_childhood/pages/auth_page.dart';
import 'package:sunny_childhood/screen/news_screen.dart';
import 'package:sunny_childhood/const/colors.dart';
import 'package:sunny_childhood/menu.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Головна сторінка"),
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
