// news_model.dart

class News {
  String id;
  String text;
  String title;

  News(this.id, this.text, this.title);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'title': title,
    };
  }

  factory News.fromMap(Map<String, dynamic> map, String documentId) {
    return News(
      documentId,
      map['text'],
      map['title'],
    );
  }
}


