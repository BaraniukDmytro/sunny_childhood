import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sunny_childhood/const/colors.dart';
import 'package:sunny_childhood/screen/add_lesson_screen.dart';
import 'package:sunny_childhood/widgets/stream_note.dart';

class Lesson_Screen extends StatefulWidget {
  const Lesson_Screen({super.key});

  @override
  State<Lesson_Screen> createState() => _Lesson_ScreenState();
}

bool show = true;

class _Lesson_ScreenState extends State<Lesson_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddLessonScreen(),
            ));
          },
          backgroundColor: custom_green,
          child: Icon(Icons.add, size: 30),
        ),
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              setState(() {
                show = true;
              });
            }
            if (notification.direction == ScrollDirection.reverse) {
              setState(() {
                show = false;
              });
            }
            return true;
          },
          child: Column(
            children: [
              Stream_note(false),
              Text(
                'Completed',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.bold),
              ),
              Stream_note(true),
            ],
          ),
        ),
      ),
    );
  }
}
