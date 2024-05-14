import 'package:flutter/material.dart';
import '../const/colors.dart';
import '../menu.dart';

class UsersPage extends StatelessWidget{
  const UsersPage({super.key});

  @override
  Widget build( BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        backgroundColor: custom_green,
        elevation: 0,
      ),
      drawer: AppMenu(),


    );
  }
}