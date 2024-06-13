import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sunny_childhood/ViewModel/userViewModel.dart';
import '../const/colors.dart';
import '../menu.dart';
import '../screen/edit_profile_screen.dart';

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
      userData = await UserViewModel().getUserData(user.uid);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _updateUserData() async {
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(userData: userData),
      ),
    );

    if (updatedData != null) {
      setState(() {
        isLoading = true;
      });

      User? user = _auth.currentUser;
      if (user != null) {
        bool success = await UserViewModel().updateUserData(user.uid, updatedData);
        if (success) {
          userData = updatedData;
        }
      }

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
        title: Text("Профіль"),
        backgroundColor: custom_green,
      ),
      drawer: AppMenu(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
        children: [
          const SizedBox(height: 50),
          _buildAvatar(),
          const SizedBox(height: 20),
          _buildProfileDetail('Імя', userData?['name']),
          _buildProfileDetail('Email', _auth.currentUser?.email),
          _buildProfileDetail('Вік', userData?['age']),
          _buildProfileDetail('Додаткова інформація', userData?['additionalInfo']),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _updateUserData,
              style: ElevatedButton.styleFrom(
                backgroundColor: custom_green, // Зелений колір кнопки
              ),
              child: Text('Оновити',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
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

