import 'package:flutter/material.dart';
import 'package:quowally/ui/widgets/quote_styling/select_quote_list_tile.dart';
import 'package:quowally/ui/widgets/quote_styling/select_quote_tile.dart';
import 'package:quowally/ui/widgets/quote_styling/text_alignment_tile.dart';
import 'package:quowally/ui/widgets/quote_styling/text_color_tile.dart';
import 'package:quowally/ui/widgets/quote_styling/text_font_style_tile.dart';
import 'package:quowally/ui/widgets/quote_styling/text_font_tile.dart';
import 'package:quowally/ui/widgets/quote_styling/text_size_tile.dart';
import 'package:quowally/ui/widgets/quote_styling/text_weight_tile.dart';
import 'package:quowally/ui/widgets/quote_styling/update_quote_interval.dart';
import 'package:quowally/ui/widgets/quote_styling/wallpaper_color_tile.dart';

class QuoteStylingList extends StatefulWidget {
  final bool fromAutoChange;

  const QuoteStylingList({
    super.key, this.fromAutoChange = false,
  });

  @override
  State<QuoteStylingList> createState() => _QuoteStylingListState();
}

class _QuoteStylingListState extends State<QuoteStylingList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextColorTile(),
          Divider(height: 0, color: Colors.brown[100]),
          WallpaperColorTile(),
          Divider(height: 0, color: Colors.brown[100]),
          TextSizeTile(),
          Divider(height: 0, color: Colors.brown[100]),
          TextFontTile(),
          Divider(height: 0, color: Colors.brown[100]),
          TextWeightTile(),
          Divider(height: 0, color: Colors.brown[100]),
          TextFontStyleTile(),
          Divider(height: 0, color: Colors.brown[100]),
          TextAlignmentTile(),
          Divider(height: 0, color: Colors.brown[100]),
          widget.fromAutoChange ? SelectQuoteListTile(): SelectQuoteTile(),
          Divider(height: 0, color: Colors.brown[100]),
          if(widget.fromAutoChange)
            UpdateQuoteInterval(),
          Divider(height: 0, color: Colors.brown[100]),
        ],
      ),
    );
  }
}
