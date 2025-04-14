import 'package:flutter/material.dart';
import 'package:flutter_quote_wallpaper_app/ui/widgets/quote_styling/select_quote_tile.dart';
import 'package:flutter_quote_wallpaper_app/ui/widgets/quote_styling/text_alignment_tile.dart';
import 'package:flutter_quote_wallpaper_app/ui/widgets/quote_styling/text_color_tile.dart';
import 'package:flutter_quote_wallpaper_app/ui/widgets/quote_styling/text_font_style_tile.dart';
import 'package:flutter_quote_wallpaper_app/ui/widgets/quote_styling/text_font_tile.dart';
import 'package:flutter_quote_wallpaper_app/ui/widgets/quote_styling/text_size_tile.dart';
import 'package:flutter_quote_wallpaper_app/ui/widgets/quote_styling/text_weight_tile.dart';
import 'package:flutter_quote_wallpaper_app/ui/widgets/quote_styling/wallpaper_color_tile.dart';

class QuoteStylingList extends StatefulWidget {
  const QuoteStylingList({
    super.key,
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
          SelectQuoteTile(),
          Divider(height: 0, color: Colors.brown[100]),
        ],
      ),
    );
  }
}
