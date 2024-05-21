import 'package:flutter/material.dart';
import '../const/colors.dart';
import '../menu.dart';
import 'package:sunny_childhood/repository/firestore.dart';

class InstructionPage extends StatefulWidget {
  const InstructionPage({Key? key}) : super(key: key);

  @override
  _InstructionPageState createState() => _InstructionPageState();
}

class _InstructionPageState extends State<InstructionPage> {
  String? instructionText;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInstructionText();
  }

  Future<void> _loadInstructionText() async {
    String? text = await Firestore_Datasource().getInstructionText();
    setState(() {
      instructionText = text;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instruction"),
        backgroundColor: custom_green,
        elevation: 0,
      ),
      drawer: AppMenu(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200, // Висота зображення інструкції
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/instruction_image.jpg'), // Шлях до зображення інструкції
                  fit: BoxFit.cover, // Прилаштування розміру зображення
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                instructionText ?? 'No instructions available.',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

