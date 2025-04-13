// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_quote_wallpaper_app/models/author_style.dart';
import 'package:flutter_quote_wallpaper_app/models/quote_style.dart';

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
    required this.authorStyle,
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
}
