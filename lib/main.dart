import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sunny_childhood/pages/instruction_page.dart';
import 'package:sunny_childhood/pages/main_page.dart';
import 'package:sunny_childhood/pages/profile_page.dart';
import 'package:sunny_childhood/pages/progress_page.dart';
import 'package:sunny_childhood/pages/schedule_page.dart';
import 'package:sunny_childhood/firebase_options.dart';
import 'package:sunny_childhood/pages/users_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
      routes: {
        '/profile_page':(context) => const ProfilePage(),
        '/users_page':(context) => const UsersPage(),
        '/schedule_page':(context) => const SchedulePage(),
        '/home_page':(context) => const MainPage(),
        '/progress_page':(context) => const ProgressPage(),
        '/instruction_page':(context) => const InstructionPage(),
      },
    );
  }
}
