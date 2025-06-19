// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'package:quowally/models/author_style.dart';
import 'package:quowally/models/quote_style.dart';

class Quote {
  final String quote;
  final String author;
  final QuoteStyle quoteStyle;
  
  // because updated authorStyle will assigned later 
  // (when user finally saves[for autoChanged quote] or 
  // clicked set wallpaper button)
  AuthorStyle authorStyle;

  Quote({
    required this.quote,
    this.author = "Shri Krishna Vasudeva Yadav",
    required this.quoteStyle,
    required this.authorStyle
  });

  Quote copyWith({
    String? quote,
    String? author,
    QuoteStyle? quoteStyle,
    AuthorStyle? authorStyle,
  }) {
    return Quote(
      quote: quote ?? this.quote,
      author: author ?? this.author,
      quoteStyle: quoteStyle ?? this.quoteStyle,
      authorStyle: authorStyle ?? this.authorStyle,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quote': quote,
      'author': author,
      'quoteStyle': quoteStyle.toMap(),
      'authorStyle': authorStyle.toMap(),
    };
  }

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      quote: (map["quote"] ?? '') as String,
      author: (map["author"] ?? '') as String,
      quoteStyle: QuoteStyle.fromMap((map["quoteStyle"]?? Map<String,dynamic>.from({})) as Map<String,dynamic>),
      authorStyle: AuthorStyle.fromMap((map["authorStyle"]?? Map<String,dynamic>.from({})) as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Quote.fromJson(String source) => Quote.fromMap(json.decode(source) as Map<String, dynamic>);
}
