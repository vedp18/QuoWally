// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_quote_wallpaper_app/models/author_style.dart';
import 'package:flutter_quote_wallpaper_app/models/quote_style.dart';

class Quote {
  final String quote;
  final String author;
  final QuoteStyle quoteStyle;
  final AuthorStyle authorStyle;

  const Quote({
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
