// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:quowally/models/author_style.dart';
import 'package:quowally/models/quote_style.dart';

class Quote {
  final String quote;
  final String author;
  final QuoteStyle quoteStyle;
  final bool isFavourite;

  // because updated authorStyle will assigned later
  // (when user finally saves[for autoChanged quote] or
  // clicked set wallpaper button)
  AuthorStyle authorStyle;

  Quote(
      {required this.quote,
      this.author = "Shri Krishna Vasudeva Yadav",
      this.isFavourite = false,
      required this.quoteStyle,
      required this.authorStyle});

  Quote copyWith({
    String? quote,
    String? author,
    bool? isFavourite,
    QuoteStyle? quoteStyle,
    AuthorStyle? authorStyle,
  }) {
    return Quote(
      quote: quote ?? this.quote,
      author: author ?? this.author,
      isFavourite: isFavourite ?? this.isFavourite,
      quoteStyle: quoteStyle ?? this.quoteStyle,
      authorStyle: authorStyle ?? this.authorStyle,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quote': quote,
      'author': author,
      'isFavourite': isFavourite,
      'quoteStyle': quoteStyle.toMap(),
      'authorStyle': authorStyle.toMap(),
    };
  }

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      quote: (map["quote"] ?? '') as String,
      author: (map["author"] ?? '') as String,
      isFavourite: (map["isFavourite"] ?? false) as bool,
      quoteStyle: QuoteStyle.fromMap(
        ((map["quoteStyle"] ?? {}) as Map).map(
          (k, v) => MapEntry(k.toString(), v),
        ),
      ),
      authorStyle: AuthorStyle.fromMap(
        ((map["authorStyle"] ?? {}) as Map).map(
          (k, v) => MapEntry(k.toString(), v),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Quote.fromJson(String source) =>
      Quote.fromMap(json.decode(source) as Map<String, dynamic>);
}
