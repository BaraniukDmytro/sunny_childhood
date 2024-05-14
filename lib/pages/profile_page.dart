import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunny_childhood/repository/firestore.dart';

import '../const/colors.dart';
import '../menu.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: custom_green,
      ),
      body: ListView(
      children: [
        const SizedBox(height: 50),
        Icon(
          Icons.person,
          size: 80,
        )
      ],
        ),
    );
  }
}