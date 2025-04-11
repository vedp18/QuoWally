// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class QuoteStyle {
  final double quoteSize;
  final String quoteFont;
  final FontStyle quoteFontStyle;
  final FontWeight quoteWeight;
  final TextAlign quoteAlignment;
  final Color quoteColor;
  final Color wallpaperColor;


  QuoteStyle({
    this.quoteSize = 16,
    this.quoteFont = "Tiro Devanagari Sanskrit",
    this.quoteFontStyle = FontStyle.normal,
    this.quoteWeight = FontWeight.w600,
    this.quoteAlignment= TextAlign.center,
    this.quoteColor = const Color.fromRGBO(78, 52, 46, 1),
    this.wallpaperColor = const Color.fromARGB(255, 29, 19, 17)

  });


  QuoteStyle copyWith({
    double? quoteSize,
    String? quoteFont,
    FontStyle? quoteFontStyle,
    FontWeight? quoteWeight,
    TextAlign? quoteAlignment,
    Color? quoteColor,
    Color? wallpaperColor, required ,
  }) {
    return QuoteStyle(
      quoteSize: quoteSize ?? this.quoteSize,
      quoteFont: quoteFont ?? this.quoteFont,
      quoteFontStyle: quoteFontStyle ?? this.quoteFontStyle,
      quoteWeight: quoteWeight ?? this.quoteWeight,
      quoteAlignment: quoteAlignment ?? this.quoteAlignment,
      quoteColor: quoteColor ?? this.quoteColor,
      wallpaperColor: wallpaperColor ?? this.wallpaperColor,
    );
  }


}
