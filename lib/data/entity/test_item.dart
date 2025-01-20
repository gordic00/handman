import 'dart:convert';

class TestItem {
  int id;
  String title;
  String description;
  String? imgUrl;

  TestItem(
      {required this.id,
      required this.title,
      required this.description,
      this.imgUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'img_url': imgUrl,
    };
  }

  factory TestItem.fromMap(Map<String, dynamic> map) {
    return TestItem(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      imgUrl: map['img_url'] as String,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory TestItem.fromJson(Map<String, dynamic> source) =>
      TestItem.fromMap(source);
}
