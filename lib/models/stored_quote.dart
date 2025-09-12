// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

import 'package:quowally/models/author_style.dart';
import 'package:quowally/models/quote.dart';
import 'package:quowally/models/quote_style.dart';

part 'stored_quote.g.dart';

@HiveType(typeId: 0)
class StoredQuote {
  @HiveField(0)
  String quoteText;

  @HiveField(1)
  String authorText;

  @HiveField(2)
  bool isFavourite;

  StoredQuote({
    required this.quoteText,
    required this.authorText,
    this.isFavourite = false,
  });

  // Convert to full Quote model (use default style)
  Quote toFullQuote(
      QuoteStyle defaultQuoteStyle, AuthorStyle defaultAuthorStyle) {
    return Quote(
      quote: quoteText,
      author: authorText,
      isFavourite: isFavourite,
      quoteStyle: defaultQuoteStyle,
      authorStyle: defaultAuthorStyle,
    );
  }

  // Convert from full Quote to stored version
  static StoredQuote fromQuote(Quote quote) {
    return StoredQuote(
      quoteText: quote.quote,
      authorText: quote.author,
      isFavourite: quote.isFavourite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quote': quoteText,
      'author': authorText,
      'isFavourite': isFavourite,
    };
  }

  factory StoredQuote.fromMap(Map<String, dynamic> map) {
    return StoredQuote(
      quoteText: (map["quote"] ?? '') as String,
      authorText: (map["author"] ?? '') as String,
      isFavourite: (map["isFavourite"] ?? false) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoredQuote.fromJson(String source) =>
      StoredQuote.fromMap(json.decode(source) as Map<String, dynamic>);

  StoredQuote copyWith({
    String? quoteText,
    String? authorText,
    bool? isFavourite,
  }) {
    return StoredQuote(
      quoteText: quoteText ?? this.quoteText,
      authorText: authorText ?? this.authorText,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
