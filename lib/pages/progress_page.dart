import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sunny_childhood/ViewModel/progressViewModel.dart';
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
      body: ChangeNotifierProvider(
        create: (_) => ProgressViewModel()..fetchCompletedTasksCount(),
        child: Consumer<ProgressViewModel>(
          builder: (context, ProgressViewModel, child) {
            if (ProgressViewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              int completedTasksCount = ProgressViewModel.completedTasksCount;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200, // Висота зображення інструкції
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/progress/sun-cloud.png'), // Шлях до зображення інструкції
                        fit: BoxFit.cover, // Прилаштування розміру зображення
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Image.asset(
                          'images/trees/$completedTasksCount.png', // Шлях до зображення дерева
                          width: 400, // Ширина зображення дерева
                          height: 400, // Висота зображення дерева
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Completed tasks: $completedTasksCount',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

