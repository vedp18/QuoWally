import 'package:flutter/material.dart';

class QuoteStylingValues {
  
  /// colors
  static final Map<Color, String> colors = {
    const Color.from(alpha: 1, red: 0.62, green: 0.62, blue: 0.62): "Grey",
    const Color.from(alpha: 0.102, red: 1, green: 1, blue: 1): "White10",
    const Color.from(alpha: 1, red: 0, green: 0, blue: 0): "Black",
    const Color.from(alpha: 1, red: 0.475, green: 0.333, blue: 0.282): "Brown",
    const Color.from(alpha: 1, red: 0.306, green: 0.204, blue: 0.18): "Dark Brown",
    const Color.from(alpha: 1, red: 0.114, green: 0.075, blue: 0.067): "Darkest Brown",
    const Color.from(alpha: 1, red: 0.404, green: 0.227, blue: 0.718): "Deep Purple",
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
