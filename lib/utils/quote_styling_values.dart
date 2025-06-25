import 'package:flutter/material.dart';

class QuoteStylingValues {
  /// colors
  /// ? first set  of colors i used
  // static final Map<Color, String> colors = {
  //   const Color.from(alpha: 1, red: 0.62, green: 0.62, blue: 0.62): "Grey",
  //   const Color.from(alpha: 0.102, red: 1, green: 1, blue: 1): "White10",
  //   const Color.from(alpha: 1, red: 0, green: 0, blue: 0): "Black",
  //   const Color.from(alpha: 1, red: 0.475, green: 0.333, blue: 0.282): "Brown",
  //   const Color.from(alpha: 1, red: 0.306, green: 0.204, blue: 0.18): "Dark Brown",
  //   const Color.from(alpha: 1, red: 0.114, green: 0.075, blue: 0.067): "Darkest Brown",
  //   const Color.from(alpha: 1, red: 0.404, green: 0.227, blue: 0.718): "Deep Purple",
  // };
  //

  static final Map<Color, String> colors = {
    const Color.from(alpha: 1, red: 1, green: 1, blue: 1): "White",
    const Color.from(alpha: 1, red: 0, green: 0, blue: 0): "Black",
    const Color.from(alpha: 1, red: 0.62, green: 0.62, blue: 0.62): "Grey",
    const Color.from(alpha: 1, red: 0.475, green: 0.333, blue: 0.282): "Brown",
    const Color.from(alpha: 1, red: 0.306, green: 0.204, blue: 0.18):
        "Dark Brown",
    const Color.from(alpha: 1, red: 0.114, green: 0.075, blue: 0.067):
        "Darkest Brown",
    const Color.from(alpha: 1, red: 0.404, green: 0.227, blue: 0.718):
        "Deep Purple",
    const Color.from(alpha: 1, red: 0.247, green: 0.318, blue: 0.709): "Indigo",
    const Color.from(alpha: 1, red: 0.129, green: 0.588, blue: 0.953): "Blue",
    const Color.from(alpha: 1, red: 0.012, green: 0.663, blue: 0.792): "Cyan",
    const Color.from(alpha: 1, red: 0.0, green: 0.588, blue: 0.533): "Teal",
    const Color.from(alpha: 1, red: 0.298, green: 0.686, blue: 0.314): "Green",
    const Color.from(alpha: 1, red: 0.545, green: 0.765, blue: 0.290):
        "Light Green",
    const Color.from(alpha: 1, red: 1, green: 0.921, blue: 0.231): "Yellow",
    const Color.from(alpha: 1, red: 1, green: 0.756, blue: 0.027): "Amber",
    const Color.from(alpha: 1, red: 1, green: 0.596, blue: 0.0): "Orange",
    const Color.from(alpha: 1, red: 1, green: 0.341, blue: 0.133):
        "Deep Orange",
    const Color.from(alpha: 1, red: 0.957, green: 0.263, blue: 0.212): "Red",
    const Color.from(alpha: 1, red: 0.914, green: 0.118, blue: 0.388): "Pink",
    const Color.from(alpha: 1, red: 0.612, green: 0.153, blue: 0.690): "Purple",
    const Color.from(alpha: 1, red: 0.376, green: 0.490, blue: 0.545):
        "Blue Grey",
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
    'Lato',
    'Noto Serif',
    'Sofia',
    'Domine',
    'Smythe',
    'Old Standard TT',
    'Fondamento',
    'Cormorant Infant',
    'Cookie',
    'Tangerine',
    'Major Mono Display',
    'Italianno',
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
