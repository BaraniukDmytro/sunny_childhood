import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunny_childhood/repository/firestore.dart';

import '../const/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = _auth.currentUser;
    if (user != null) {
      userData = await Firestore_Datasource().getUserData(user.uid);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: custom_green,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
        children: [
          const SizedBox(height: 50),
          _buildAvatar(),
          const SizedBox(height: 20),
          _buildProfileDetail('Name', userData?['name']),
          _buildProfileDetail('Email', _auth.currentUser?.email),
          _buildProfileDetail('Age', userData?['age']),
          _buildProfileDetail('Additional Info', userData?['additionalInfo']),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Center(
      child: userData?['avatarUrl'] != null
          ? Image.asset(
        userData!['avatarUrl'],
        width: 150,
        height: 150,
      )
          : Icon(
        Icons.person,
        size: 80,
      ),
    );
  }

  Widget _buildProfileDetail(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        child: ListTile(
          title: Text(title),
          subtitle: Text(value ?? 'Not available'),
        ),
      ),
    );
  }
}
