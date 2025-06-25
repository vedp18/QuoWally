// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ui';

import 'package:quowally/models/author_style.dart';
import 'package:quowally/models/quote.dart';
import 'package:quowally/models/quote_style.dart';

class Wallpaper {
  final Color wallpaperColor;
  Quote? quote;

  Wallpaper({
    this.wallpaperColor =
        const Color.from(alpha: 1, red: 0, green: 0, blue: 0),
    this.quote,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'wallpaperColor': <String, double>{
        'a': wallpaperColor.a,
        'r': wallpaperColor.r,
        'g': wallpaperColor.g,
        'b': wallpaperColor.b,
      },
      'quote': quote?.toMap(),
    };
  }

  factory Wallpaper.fromMap(Map<String, dynamic> map) {
    final wallpaperColor = map['wallpaperColor'];

    return Wallpaper(
      wallpaperColor: Color.from(
        alpha: wallpaperColor['a'],
        red: wallpaperColor['r'],
        green: wallpaperColor['g'],
        blue: wallpaperColor['b'],
      ),
      quote: map['quote'] != null
          ? Quote.fromMap(
            ((map["quote"] ?? {}) as Map).map(
                (k, v) => MapEntry(k.toString(), v),
              ),
            // (map["quote"] ?? Map<String, dynamic>.from({}))
            //   as Map<String, dynamic>
              )
          : Quote(
              quote: "This is Hiii, from deeep inside Wallpaper Model",
              quoteStyle: QuoteStyle(),
              authorStyle: AuthorStyle(),
            ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Wallpaper.fromJson(String source) =>
      Wallpaper.fromMap(json.decode(source) as Map<String, dynamic>);

  Wallpaper copyWith({
    Color? wallpaperColor,
    Quote? quote,
  }) {
    return Wallpaper(
      wallpaperColor: wallpaperColor ?? this.wallpaperColor,
      quote: quote ?? this.quote,
    );
  }
}
