// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  AuthorStyle copyWith({
    double? authorSize,
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
}
