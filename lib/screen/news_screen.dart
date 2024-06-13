import 'package:flutter/material.dart';
import 'package:sunny_childhood/ViewModel/newsViewModel.dart';
import 'package:sunny_childhood/model/news_model.dart';
import 'package:sunny_childhood/screen/add_news_screen.dart';

import 'edit_news_screen.dart'; // Це екран для додавання новин, який ми створимо нижче


class NewsScreen extends StatelessWidget {
  final NewsViewModel _newsViewModel = NewsViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<News>>(
        stream: _newsViewModel.getNewsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No news available'));
          } else {
            final newsList = snapshot.data!;
            return ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                final news = newsList[index];
                return ListTile(
                  title: Text(news.title),
                  subtitle: Text(news.text),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditNewsScreen(news: news),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await _newsViewModel.deleteNews(news.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddNewsPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
