import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quote_wallpaper_app/blocs/quote_bloc/quote_bloc.dart';
import 'package:flutter_quote_wallpaper_app/blocs/wallpaper_bloc/wallpaper_bloc.dart';
import 'package:flutter_quote_wallpaper_app/utils/alignments_list.dart';
import 'package:flutter_quote_wallpaper_app/utils/colors_list.dart';
import 'package:flutter_quote_wallpaper_app/models/quote_style.dart';
import 'package:flutter_quote_wallpaper_app/utils/font_style_list.dart';
import 'package:flutter_quote_wallpaper_app/utils/font_weight_list.dart';
import 'package:flutter_quote_wallpaper_app/utils/fonts_list.dart';
import 'package:flutter_quote_wallpaper_app/utils/size_list.dart';
import 'package:google_fonts/google_fonts.dart';

class QuoteListTile extends StatefulWidget {
  final QuoteStyle currentQuoteStyle;
  final Color wallpaperColor;

  const QuoteListTile(
      {super.key,
      required this.currentQuoteStyle,
      required this.wallpaperColor});

  @override
  State<QuoteListTile> createState() => _QuoteListTileState();
}

class _QuoteListTileState extends State<QuoteListTile> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildSelectTextColorTile(widget.currentQuoteStyle),
        _buildSelectBackgroundColorTile(widget.wallpaperColor),
        _buildTextSizeTile(widget.currentQuoteStyle),
        _buildTextFontTile(widget.currentQuoteStyle),
        _buildTextWeightTile(widget.currentQuoteStyle),
        _buildTextFontStyleTile(widget.currentQuoteStyle),
        _buildTextAlignmentTile(widget.currentQuoteStyle),
        _buildSelectQuoteTile(widget.currentQuoteStyle),
      ],
    );
  }

  Widget _buildSelectTextColorTile(QuoteStyle currentQuoteStyle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Text Color: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown[500],
                fontSize: 11,
              ),
              children: [
                TextSpan(
                  text:
                      'Sets the text color of the quote and author name. For instance, if you have a dark wallpaper then set the color to white.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.brown[300],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // spacing: 14,
              children: [
                Text(
                  'Text Color:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[700],
                  ),
                ),
                DropdownButton2<Color>(
                  buttonStyleData: ButtonStyleData(
                    width: 185,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    width: 150,
                    maxHeight: 300,
                  ),
                  isExpanded: true,
                  // menuWidth: 150,
                  value: currentQuoteStyle.quoteColor,
                  onChanged: (value) {
                    context
                        .read<QuoteBloc>()
                        .add(QuoteColorChangedEvent(newColor: value!));
                  },
                  underline: const SizedBox(),
                  items: ColorList.colors.keys.map((Color value) {
                    return DropdownMenuItem<Color>(
                      value: value,
                      child: Row(
                        // mainAxisSize: MainAxisSize.min,
                        spacing: 10,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            color: value,
                          ),
                          Text(
                            ColorList.colors[value]!,
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectBackgroundColorTile(Color wallpaperColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Wallpaper Color: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown[500],
                fontSize: 11,
              ),
              children: [
                TextSpan(
                  text:
                      'Sets the background wallpaper color with the quote and author name. For instance, if you want a dark solid wallpaper then set the color to grey or dark color.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.brown[300],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 14,
              children: [
                Text(
                  'Wallpaper Color:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[700],
                  ),
                ),
                DropdownButton2<Color>(
                  buttonStyleData: ButtonStyleData(
                    width: 185,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    width: 150,
                    maxHeight: 300,
                  ),
                  isExpanded: true,
                  // menuWidth: 150,
                  value: wallpaperColor,
                  onChanged: (value) {
                    context.read<WallpaperBloc>().add(
                        WallpaperColorChangedEvent(newWallpaperColor: value!));
                  },
                  underline: const SizedBox(),
                  items: ColorList.colors.keys.map((Color value) {
                    return DropdownMenuItem<Color>(
                      value: value,
                      child: Row(
                        // mainAxisSize: MainAxisSize.min,
                        spacing: 10,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            color: value,
                          ),
                          Text(
                            ColorList.colors[value]!,
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextSizeTile(QuoteStyle currentQuoteStyle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Text Size: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown[500],
                fontSize: 11,
              ),
              children: [
                TextSpan(
                  text:
                      'Sets the text size of the quote and author name. For instance, if you have a dark wallpaper then set the text color to white.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.brown[300],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 14,
              children: [
                Text(
                  'Text Size:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[700],
                  ),
                ),
                DropdownButton2<double>(
                  buttonStyleData: ButtonStyleData(
                    width: 185,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    width: 150,
                    maxHeight: 300,
                  ),
                  // menuMaxHeight: 300,
                  isExpanded: true,
                  // menuWidth: 200,
                  value: currentQuoteStyle.quoteSize,
                  onChanged: (value) {
                    context
                        .read<QuoteBloc>()
                        .add(QuoteSizeChangedEvent(newSize: value!));
                  },
                  underline: const SizedBox(),
                  items: SizeList.sizeValueToLabel.keys.map((double value) {
                    return DropdownMenuItem<double>(
                      value: value,
                      child: Text(
                        SizeList.sizeValueToLabel[value]!,
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFontTile(QuoteStyle currentQuoteStyle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Text Font: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown[500],
                fontSize: 11,
              ),
              children: [
                TextSpan(
                  text:
                      'Sets the text font of the quote and author name. For instance, if you have a dark wallpaper then set the text color to white.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.brown[300],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 14,
              children: [
                Text(
                  'Text Font:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[700],
                  ),
                ),
                DropdownButton2<String>(
                  buttonStyleData: ButtonStyleData(
                    width: 185,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    width: 150,
                    maxHeight: 300,
                  ),
                  isExpanded: true,
                  // menuWidth: 200,
                  value: currentQuoteStyle.quoteFont,
                  onChanged: (value) {
                    context
                        .read<QuoteBloc>()
                        .add(QuoteFontChangedEvent(newFont: value!));
                  },
                  underline: const SizedBox(),
                  items: FontsList.fonts.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: GoogleFonts.getFont(
                          value,
                          textStyle:
                              TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFontStyleTile(QuoteStyle currentQuoteStyle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Font Style: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown[500],
                fontSize: 11,
              ),
              children: [
                TextSpan(
                  text:
                      'Sets the font style of the quote and author name. For instance, if you have a dark wallpaper then set the text color to white.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.brown[300],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 14,
              children: [
                Text(
                  'Font Style:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[700],
                  ),
                ),
                DropdownButton2<FontStyle>(
                  buttonStyleData: ButtonStyleData(
                    width: 185,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    width: 150,
                    maxHeight: 300,
                  ),
                  isExpanded: true,
                  // menuWidth: 200,
                  value: currentQuoteStyle.quoteFontStyle,
                  onChanged: (value) {
                    context
                        .read<QuoteBloc>()
                        .add(QuoteFontStyleChangedEvent(newFontStyle: value!));
                  },
                  underline: const SizedBox(),
                  items: FontStyleList.fontStyles.keys.map((FontStyle value) {
                    return DropdownMenuItem<FontStyle>(
                      value: value,
                      child: Text(
                        FontStyleList.fontStyles[value]!,
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextWeightTile(QuoteStyle currentQuoteStyle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Text Weight: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown[500],
                fontSize: 11,
              ),
              children: [
                TextSpan(
                  text:
                      'Sets the text weight of the quote and author name. For instance, if you have a dark wallpaper then set the text color to white.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.brown[300],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 14,
              children: [
                Text(
                  'Text Weight:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[700],
                  ),
                ),
                DropdownButton2<FontWeight>(
                  buttonStyleData: ButtonStyleData(
                    width: 185,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    width: 150,
                    maxHeight: 300,
                  ),
                  isExpanded: true,
                  // menuWidth: 200,
                  value: currentQuoteStyle.quoteWeight,
                  onChanged: (value) {
                    context
                        .read<QuoteBloc>()
                        .add(QuoteWeightChangedEvent(newWeight: value!));
                  },
                  underline: const SizedBox(),
                  items: FontWeightList.fontWeights.keys.map((FontWeight value) {
                    return DropdownMenuItem<FontWeight>(
                      value: value,
                      child: Text(
                        FontWeightList.fontWeights[value]!,
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextAlignmentTile(QuoteStyle currentQuoteStyle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Text Alignment: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown[500],
                fontSize: 11,
              ),
              children: [
                TextSpan(
                  text:
                      'Sets the text alignment of the quote and author name. For instance, if you have a dark wallpaper then set the text color to white.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.brown[300],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 14,
              children: [
                Text(
                  'Text Alignment:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[700],
                  ),
                ),
                DropdownButton2<TextAlign>(
                  buttonStyleData: ButtonStyleData(
                    width: 185,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    width: 150,
                    maxHeight: 300,
                  ),
                  isExpanded: true,
                  // menuWidth: 200,
                  value: currentQuoteStyle.quoteAlignment,
                  onChanged: (value) {
                    context
                        .read<QuoteBloc>()
                        .add(QuoteAlignmentChangedEvent(newAlignment: value!));
                  },
                  underline: const SizedBox(),
                  items: AlignmentsList.alignments.keys.map((TextAlign value) {
                    return DropdownMenuItem<TextAlign>(
                      value: value,
                      child: Text(
                        AlignmentsList.alignments[value]!,
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectQuoteTile(QuoteStyle currentQuoteStyle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Select Quote: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown[500],
                fontSize: 11,
              ),
              children: [
                TextSpan(
                  text:
                      'Sets the text color of the quote and author name. For instance, if you have a dark wallpaper then set the text color to white.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.brown[300],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 14,
              children: [
                Text(
                  'Select Quote:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[700],
                  ),
                ),
                DropdownButton2<String>(
                  buttonStyleData: ButtonStyleData(
                    width: 185,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    width: 150,
                    maxHeight: 300,
                  ),
                  isExpanded: true,
                  value: 'white',
                  onChanged: (value) {},
                  underline: const SizedBox(),
                  items:
                      ['white', 'black', 'brown', 'blue'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
