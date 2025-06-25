// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class QuoteStyle {
  final double quoteSize;
  final String quoteFont;
  final FontStyle quoteFontStyle;
  final FontWeight quoteWeight;
  final TextAlign quoteAlignment;
  final Color quoteColor;
  // final Color wallpaperColor;

  QuoteStyle({
    this.quoteSize = 16,
    this.quoteFont = 'Fondamento',
    this.quoteFontStyle = FontStyle.normal,
    this.quoteWeight = FontWeight.w600,
    this.quoteAlignment = TextAlign.justify,
    this.quoteColor = const Color.from(alpha: 1, red: 0.62, green: 0.62, blue: 0.62),
    // this.wallpaperColor = const Color.fromARGB(255, 29, 19, 17)
  });

  QuoteStyle copyWith({
    double? quoteSize,
    String? quoteFont,
    FontStyle? quoteFontStyle,
    FontWeight? quoteWeight,
    TextAlign? quoteAlignment,
    Color? quoteColor,
    Color? wallpaperColor,
    required,
  }) {
    return QuoteStyle(
      quoteSize: quoteSize ?? this.quoteSize,
      quoteFont: quoteFont ?? this.quoteFont,
      quoteFontStyle: quoteFontStyle ?? this.quoteFontStyle,
      quoteWeight: quoteWeight ?? this.quoteWeight,
      quoteAlignment: quoteAlignment ?? this.quoteAlignment,
      quoteColor: quoteColor ?? this.quoteColor,
      // wallpaperColor: wallpaperColor ?? this.wallpaperColor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quoteSize': quoteSize,
      'quoteFont': quoteFont,
      'quoteFontStyle': quoteFontStyle.index,
      'quoteWeight': quoteWeight.index,
      'quoteAlignment': quoteAlignment.index,
      'quoteColor': <String, double>{
        'a': quoteColor.a,
        'r': quoteColor.r,
        'g': quoteColor.g,
        'b': quoteColor.b
      },
    };
  }

  factory QuoteStyle.fromMap(Map<String, dynamic> map) {

    final quoteColor = map['quoteColor'];
    return QuoteStyle(
      quoteSize: (map["quoteSize"] ?? 0.0) as double,
      quoteFont: (map["quoteFont"] ?? '') as String,
      quoteFontStyle: FontStyle.values[map['quoteFontStyle'] ?? 0],
      quoteWeight: FontWeight.values[map['quoteWeight'] ?? 3],
      quoteAlignment: TextAlign.values[map['quoteAlignment'] ?? 0],
      // quoteFontStyle: FontStyle.va((map["quoteFontStyle"]?? Map<String,dynamic>.from({})) as Map<String,dynamic>),
      // quoteWeight: FontWeight.fromMap((map["quoteWeight"]?? Map<String,dynamic>.from({})) as Map<String,dynamic>),
      // quoteAlignment: TextAlign.fromMap((map["quoteAlignment"]?? Map<String,dynamic>.from({})) as Map<String,dynamic>),
      quoteColor: Color.from(
        alpha: quoteColor['a'],
        red: quoteColor['r'],
        green: quoteColor['g'],
        blue: quoteColor['b'],
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuoteStyle.fromJson(String source) =>
      QuoteStyle.fromMap(json.decode(source) as Map<String, dynamic>);

}
