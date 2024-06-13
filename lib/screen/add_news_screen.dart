import 'package:flutter/material.dart';
import 'package:sunny_childhood/ViewModel/newsViewModel.dart';

class AddNewsPage extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final NewsViewModel _newsViewModel = NewsViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _textController,
              decoration: InputDecoration(labelText: 'Text'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _newsViewModel.addNews(
                  _textController.text,
                  _titleController.text,
                );
                Navigator.pop(context);
              },
              child: Text('Add News'),
            ),
          ],
        ),
      ),
    );
  }
}
