import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quote_wallpaper_app/blocs/author_bloc/author_bloc.dart';
import 'package:flutter_quote_wallpaper_app/blocs/quote_bloc/quote_bloc.dart';
import 'package:flutter_quote_wallpaper_app/utils/quote_styling_values.dart';

import 'package:logger/logger.dart';

final Logger logger = Logger();
int count = 0;

class TextWeightTile extends StatelessWidget {
  const TextWeightTile({super.key});

  @override
  Widget build(BuildContext context) {
    logger.d("TextWeightTile build -${++count}");
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 10),
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
              // spacing: 9,
              children: [
                Text(
                  'Quote Text Weight:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[700],
                  ),
                ),
                BlocSelector<QuoteBloc, QuoteState, FontWeight>(
                  selector: (state) {
                    return state.updatedQuote.quoteStyle.quoteWeight;
                  },
                  builder: (context, quoteWeight) {
                    return DropdownButton2<FontWeight>(
                      buttonStyleData: ButtonStyleData(
                        width: 171,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: 150,
                        maxHeight: 300,
                      ),
                      isExpanded: true,
                      // menuWidth: 200,
                      value: quoteWeight,
                      // context
                      //     .read<QuoteBloc>()
                      //     .state
                      //     .updatedQuote
                      //     .quoteStyle
                      //     .quoteWeight,
                      onChanged: (value) {
                        context
                            .read<QuoteBloc>()
                            .add(QuoteWeightChangedEvent(newWeight: value!));
                      },
                      underline: const SizedBox(),
                      items: QuoteStylingValues.fontWeights.keys
                          .map((FontWeight value) {
                        return DropdownMenuItem<FontWeight>(
                          value: value,
                          child: Text(
                            QuoteStylingValues.fontWeights[value]!,
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
              // spacing: 9,
              children: [
                Text(
                  'Author Text Weight:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[700],
                  ),
                ),
                BlocSelector<AuthorBloc, AuthorState, FontWeight>(
                  selector: (state) {
                    return state.updatedAuthorStyle.authorWeight;
                  },
                  builder: (context, authorWeight) {
                    return DropdownButton2<FontWeight>(
                      buttonStyleData: ButtonStyleData(
                        width: 171,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: 150,
                        maxHeight: 300,
                      ),
                      isExpanded: true,
                      // menuWidth: 200,
                      value: authorWeight,
                      //  context
                      //     .read<AuthorBloc>()
                      //     .state
                      //     .updatedAuthorStyle
                      //     .authorWeight,
                      onChanged: (value) {
                        context
                            .read<AuthorBloc>()
                            .add(AuthorWeightChangedEvent(newWeight: value!));
                      },
                      underline: const SizedBox(),
                      items: QuoteStylingValues.fontWeights.keys
                          .map((FontWeight value) {
                        return DropdownMenuItem<FontWeight>(
                          value: value,
                          child: Text(
                            QuoteStylingValues.fontWeights[value]!,
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
