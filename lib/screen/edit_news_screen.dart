import 'package:flutter/material.dart';
import 'package:sunny_childhood/ViewModel/newsViewModel.dart';
import 'package:sunny_childhood/model/news_model.dart';

class EditNewsScreen extends StatelessWidget {
  final News news;
  final TextEditingController _textController;
  final TextEditingController _titleController;
  final NewsViewModel _newsViewModel = NewsViewModel();

  EditNewsScreen({required this.news})
      : _textController = TextEditingController(text: news.text),
        _titleController = TextEditingController(text: news.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редагувати'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Заголовок'),
            ),
            TextField(
              controller: _textController,
              decoration: InputDecoration(labelText: 'Teкст'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _newsViewModel.updateNews(
                  news.id,
                  _textController.text,
                  _titleController.text,
                );
                Navigator.pop(context);
              },
              child: Text('Зберегти'),
            ),
          ],
        ),
      ),
    );
  }
}
