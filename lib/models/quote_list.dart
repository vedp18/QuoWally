import 'dart:convert';

class QuoteList {
  final String name;
  final bool isPrebuilt;
  final String filename;

  const QuoteList({
    required this.name,
    this.isPrebuilt = false,
    required this.filename,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'isPrebuilt': isPrebuilt,
      'filename': filename,
    };
  }

  factory QuoteList.fromMap(Map<String, dynamic> map) {
    return QuoteList(
      name: (map["name"] ?? '') as String,
      isPrebuilt: (map["isPrebuilt"] ?? false) as bool,
      filename: (map["filename"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuoteList.fromJson(String source) => QuoteList.fromMap(json.decode(source) as Map<String, dynamic>);
}
