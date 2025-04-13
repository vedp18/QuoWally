import 'package:flutter/material.dart';

class QuoteStylingValues {
  
  /// colors
  static final Map<Color, String> colors = {
    Colors.grey: "Grey",
    Colors.white10: "White10",
    Colors.black: "Black",
    Colors.brown: "Brown",
    Color.fromRGBO(78, 52, 46, 1): "Dark Brown",
    Color.fromARGB(255, 29, 19, 17): "Darkest Brown",
    Colors.deepPurple: "Deep Purple",
  };

  /// alignments
  static final Map<TextAlign, String> quoteAlignments = {
    TextAlign.left: "Left",
    TextAlign.center: "Center",
    TextAlign.right: "Right",
    TextAlign.justify: "Justify",
  };

  static final Map<Alignment, String> authorAlignments = {
    Alignment.bottomLeft: "Left",
    Alignment.bottomCenter: "Center",
    Alignment.bottomRight: "Right",
  };

  /// font-styles
  static final Map<FontStyle, String> fontStyles = {
    FontStyle.normal: "Normal",
    FontStyle.italic: "Italic",
  };

  /// font-weights
  static final Map<FontWeight, String> fontWeights = {
    FontWeight.normal: "Regular",
    FontWeight.w300: "Light",
    FontWeight.w600: "Semi-Bold",
    FontWeight.bold: "Bold",
  };

  /// fonts
  static final List<String> fonts = [
    'Roboto',
    'Lato',
    'Noto Serif',
    'Bitter',
    'Sofia',
    'Domine',
    'Old Standard TT',
    'Fondamento',
    'Caveat',
    'Cormorant',
    'Cormorant Infant',
    'Cookie',
    'Tangerine',
    'Italianno',
    'Charm',
    'Tiro Devanagari Hindi',
    'Tiro Devanagari Sanskrit',
    'Mukta Vaani',
  ];

  /// sizes
  static final Map<double, String> sizeValueToLabel = {
    12.0: "Extra Small",
    14.0: "Small",
    16.0: "Normal",
    18.0: "Large",
    20.0: "Extra Large",
    24.0: "Super Large",
    28.0: "Hyper Large",
    32.0: "Jumbo",
  };
}
