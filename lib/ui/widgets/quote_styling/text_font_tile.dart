import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/author_bloc/author_bloc.dart';
import 'package:quowally/blocs/quote_bloc/quote_bloc.dart';
import 'package:quowally/utils/quote_styling_values.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:logger/logger.dart';

final Logger logger = Logger();
int count = 0;

class TextFontTile extends StatelessWidget {
  const TextFontTile({super.key});

  @override
  Widget build(BuildContext context) {
    logger.d("TextFontTile build -${++count}");
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 10),
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
              // spacing: 14,
              children: [
                Text(
                  'Quote Text Font:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[700],
                  ),
                ),
                BlocSelector<QuoteBloc, QuoteState, String>(
                  selector: (state) {
                    return state.updatedQuote.quoteStyle.quoteFont;
                  },
                  builder: (context, quoteFont) {
                    return DropdownButton2<String>(
                      buttonStyleData: ButtonStyleData(
                        width: 171,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: 150,
                        maxHeight: 300,
                      ),
                      isExpanded: true,
                      // menuWidth: 200,
                      value: quoteFont,
                      // context
                      //     .read<QuoteBloc>()
                      //     .state
                      //     .updatedQuote
                      //     .quoteStyle
                      //     .quoteFont,
                      onChanged: (value) {
                        context
                            .read<QuoteBloc>()
                            .add(QuoteFontChangedEvent(newFont: value!));
                      },
                      underline: const SizedBox(),
                      items: QuoteStylingValues.fonts.map((String value) {
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
                  'Author Text Font:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[700],
                  ),
                ),
                BlocSelector<AuthorBloc, AuthorState, String>(
                  selector: (state) {
                    return state.updatedAuthorStyle.authorFont;
                  },
                  builder: (context, authorFont) {
                    return DropdownButton2<String>(
                      buttonStyleData: ButtonStyleData(
                        width: 171,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: 150,
                        maxHeight: 300,
                      ),
                      isExpanded: true,
                      // menuWidth: 200,
                      value: authorFont, 
                      // context
                      //     .read<AuthorBloc>()
                      //     .state
                      //     .updatedAuthorStyle
                      //     .authorFont,
                      onChanged: (value) {
                        context
                            .read<AuthorBloc>()
                            .add(AuthorFontChangedEvent(newFont: value!));
                      },
                      underline: const SizedBox(),
                      items: QuoteStylingValues.fonts.map((String value) {
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
