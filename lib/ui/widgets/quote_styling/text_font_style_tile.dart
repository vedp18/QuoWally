import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quote_wallpaper_app/blocs/author_bloc/author_bloc.dart';
import 'package:flutter_quote_wallpaper_app/blocs/quote_bloc/quote_bloc.dart';
import 'package:flutter_quote_wallpaper_app/utils/quote_styling_values.dart';

import 'package:logger/logger.dart';

final Logger logger = Logger();
int count = 0;

class TextFontStyleTile extends StatelessWidget {
  const TextFontStyleTile({super.key});

  @override
  Widget build(BuildContext context) {
    logger.d("TextFontStyleTile build -${++count}");
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 10),
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
              // spacing: 14,
              children: [
                Text(
                  'Quote Font Style:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[700],
                  ),
                ),
                BlocSelector<QuoteBloc, QuoteState, FontStyle>(
                  selector: (state) {
                    return state.updatedQuote.quoteStyle.quoteFontStyle;
                  },
                  builder: (context, quoteFontStyle) {
                    return DropdownButton2<FontStyle>(
                      buttonStyleData: ButtonStyleData(
                        width: 171,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: 150,
                        maxHeight: 300,
                      ),
                      isExpanded: true,
                      // menuWidth: 200,
                      value: quoteFontStyle,
                      //  context
                      //     .read<QuoteBloc>()
                      //     .state
                      //     .updatedQuote
                      //     .quoteStyle
                      //     .quoteFontStyle,
                      onChanged: (value) {
                        context.read<QuoteBloc>().add(
                            QuoteFontStyleChangedEvent(newFontStyle: value!));
                      },
                      underline: const SizedBox(),
                      items: QuoteStylingValues.fontStyles.keys
                          .map((FontStyle value) {
                        return DropdownMenuItem<FontStyle>(
                          value: value,
                          child: Text(
                            QuoteStylingValues.fontStyles[value]!,
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        );
                      }).toList(),
                    );
                  },
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
                  'Author Font Style:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[700],
                  ),
                ),
                BlocSelector<AuthorBloc, AuthorState, FontStyle>(
                  selector: (state) {
                    return state.updatedAuthorStyle.authorFontStyle;
                  },
                  builder: (context, authorFontStyle) {
                    return DropdownButton2<FontStyle>(
                      buttonStyleData: ButtonStyleData(
                        width: 171,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: 150,
                        maxHeight: 300,
                      ),
                      isExpanded: true,
                      // menuWidth: 200,
                      value: authorFontStyle,
                      //  context
                      //     .read<AuthorBloc>()
                      //     .state
                      //     .updatedAuthorStyle
                      //     .authorFontStyle,
                      onChanged: (value) {
                        context.read<AuthorBloc>().add(
                            AuthorFontStyleChangedEvent(newFontStyle: value!));
                      },
                      underline: const SizedBox(),
                      items: QuoteStylingValues.fontStyles.keys
                          .map((FontStyle value) {
                        return DropdownMenuItem<FontStyle>(
                          value: value,
                          child: Text(
                            QuoteStylingValues.fontStyles[value]!,
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
