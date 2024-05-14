import 'package:flutter/material.dart';
import '../const/colors.dart';
import '../menu.dart';

class InstructionPage extends StatelessWidget{
  const InstructionPage({super.key});

  @override
  Widget build( BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Instruction"),
        backgroundColor: custom_green,
        elevation: 0,
      ),
      drawer: AppMenu(),
    );
  }
}