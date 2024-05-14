import 'package:flutter/material.dart';
import 'package:sunny_childhood/const/colors.dart';

import '../menu.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Progress"),
        backgroundColor: custom_green,
        elevation: 0,
      ),
      drawer: AppMenu(),
    );
  }
}