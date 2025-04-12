import 'package:flutter/widgets.dart';

class AlignmentsList {
  static final Map<TextAlign, String> quoteAlignments = {
    TextAlign.left:"Left",
    TextAlign.center:"Center",
    TextAlign.right: "Right",
    TextAlign.justify: "Justify",
  };

  static final Map<Alignment, String> authorAlignments = {
    Alignment.bottomLeft:"Left",
    Alignment.bottomCenter:"Center",
    Alignment.bottomRight: "Right",
  };
}