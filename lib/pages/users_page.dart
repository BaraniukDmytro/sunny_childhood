import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../const/colors.dart';
import '../menu.dart';
import '../screen/news_screen.dart';
import 'auth_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Волонтери"),
        backgroundColor: custom_green,
        elevation: 0,
      ),
      drawer: AppMenu(),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return VolunteerList();
          } else {
            return Auth_Page();
          }
        },
      ),
    );
  }
}

class VolunteerList extends StatelessWidget {
  const VolunteerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'employee')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Помилка: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('Немає зареєстрованих співробітників'));
        } else {
          final users = snapshot.data!.docs;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.person), // Стандартна іконка користувача
                ),
                title: Text(user['name']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user['email']),
                    Text('Додаткова інформація: ${user['additionalInfo']}'),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
