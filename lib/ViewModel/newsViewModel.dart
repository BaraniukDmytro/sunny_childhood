import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sunny_childhood/model/news_model.dart';

class NewsViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addNews(String text, String title) async {
    try {
      final newDocRef = _firestore.collection('news').doc();

      final news = News(
        newDocRef.id,
        text,
        title,
      );

      await newDocRef.set(news.toMap());
    } catch (e) {
      print('Failed to add news: $e');
      rethrow;
    }
  }

  Future<void> updateNews(String id, String text, String title) async {
    try {
      final newsDocRef = _firestore.collection('news').doc(id);

      await newsDocRef.update({
        'text': text,
        'title': title,
      });
    } catch (e) {
      print('Failed to update news: $e');
      rethrow;
    }
  }

  Future<void> deleteNews(String id) async {
    try {
      final newsDocRef = _firestore.collection('news').doc(id);

      await newsDocRef.delete();
    } catch (e) {
      print('Failed to delete news: $e');
      rethrow;
    }
  }


  Stream<List<News>> getNewsStream() {
    return _firestore.collection('news').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return News.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}



