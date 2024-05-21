import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunny_childhood/pages/auth_page.dart';
import 'package:sunny_childhood/const/colors.dart';
import 'package:sunny_childhood/screen/lessons_screen.dart';

import '../menu.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule"),
        backgroundColor: custom_green,
        elevation: 0,
      ),
      drawer: AppMenu(),

      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Lesson_Screen();
          } else {
            return Auth_Page();
          }
        },
      ),
    );
  }
}