// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class AuthorStyle {
  final double authorSize;
  final String authorFont;
  final FontStyle authorFontStyle;
  final FontWeight authorWeight;
  final Alignment authorAlignment;
  // final Color quoteColor;

  AuthorStyle({
    this.authorSize = 16,
    this.authorFont = 'Italianno',
    this.authorFontStyle = FontStyle.normal,
    this.authorWeight = FontWeight.w600,
    this.authorAlignment = Alignment.bottomRight,
    // this.quoteColor = const Color.fromRGBO(78, 52, 46, 1),
  });

  AuthorStyle copyWith(
      {double? authorSize,
      String? authorFont,
      FontStyle? authorFontStyle,
      FontWeight? authorWeight,
      Alignment? authorAlignment
      // Color? quoteColor,
      }) {
    return AuthorStyle(
      authorSize: authorSize ?? this.authorSize,
      authorFont: authorFont ?? this.authorFont,
      authorFontStyle: authorFontStyle ?? this.authorFontStyle,
      authorWeight: authorWeight ?? this.authorWeight,
      authorAlignment: authorAlignment ?? this.authorAlignment,
      // quoteColor: quoteColor ?? this.quoteColor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'authorSize': authorSize,
      'authorFont': authorFont,
      'authorFontStyle': authorFontStyle.index,
      'authorWeight': authorWeight.index,
      'authorAlignment': <String, double>{
        'x': authorAlignment.x,
        'y': authorAlignment.y,
      },
    };
  }

  factory AuthorStyle.fromMap(Map<String, dynamic> map) {
    final authorAlignment = map['authorAlignment'];
    return AuthorStyle(
      authorSize: (map["authorSize"] ?? 0.0) as double,
      authorFont: (map["authorFont"] ?? '') as String,
      authorFontStyle: FontStyle.values[map['authorFontStyle'] ?? 0],
      authorWeight: FontWeight.values[map['authorWeight'] ?? 3],
      authorAlignment: Alignment(
        authorAlignment['x'],
        authorAlignment['y'],
      ),
      // authorFontStyle: FontStyle.fromMap((map["authorFontStyle"]?? Map<String,dynamic>.from({})) as Map<String,dynamic>),
      // authorWeight: FontWeight.fromMap((map["authorWeight"]?? Map<String,dynamic>.from({})) as Map<String,dynamic>),
      // authorAlignment: Alignment.fromMap((map["authorAlignment"]?? Map<String,dynamic>.from({})) as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthorStyle.fromJson(String source) =>
      AuthorStyle.fromMap(json.decode(source) as Map<String, dynamic>);
}
