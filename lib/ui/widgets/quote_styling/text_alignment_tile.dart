import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/author_bloc/author_bloc.dart';
import 'package:quowally/blocs/quote_bloc/quote_bloc.dart';
import 'package:quowally/utils/quote_styling_values.dart';


class TextAlignmentTile extends StatelessWidget {
  const TextAlignmentTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Text Align: ',
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
              // spacing: 14,
              children: [
                Text(
                  'Quote Text Align:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[700],
                  ),
                ),
                BlocSelector<QuoteBloc, QuoteState, TextAlign>(
                  selector: (state) {
                    return state.updatedQuote.quoteStyle.quoteAlignment;
                  },
                  builder: (context, quoteAlignment) {
                    return DropdownButton2<TextAlign>(
                      buttonStyleData: ButtonStyleData(
                        width: 171,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: 150,
                        maxHeight: 300,
                      ),
                      isExpanded: true,
                      // menuWidth: 200,
                      value: quoteAlignment,
                      //  context
                      //     .read<QuoteBloc>()
                      //     .state
                      //     .updatedQuote
                      //     .quoteStyle
                      //     .quoteAlignment,
                      onChanged: (value) {
                        context.read<QuoteBloc>().add(
                            QuoteAlignmentChangedEvent(newAlignment: value!));
                      },
                      underline: const SizedBox(),
                      items: QuoteStylingValues.quoteAlignments.keys
                          .map((TextAlign value) {
                        return DropdownMenuItem<TextAlign>(
                          value: value,
                          child: Text(
                            QuoteStylingValues.quoteAlignments[value]!,
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
                  'Author Text Align:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[700],
                  ),
                ),
                BlocSelector<AuthorBloc, AuthorState, Alignment>(
                  selector: (state) {
                    return state.updatedAuthorStyle.authorAlignment;
                  },
                  builder: (context, authorAlignment) {
                    return DropdownButton2<Alignment>(
                      buttonStyleData: ButtonStyleData(
                        width: 171,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: 150,
                        maxHeight: 300,
                      ),
                      isExpanded: true,
                      // menuWidth: 200,
                      value: authorAlignment, 
                      // context
                      //     .read<AuthorBloc>()
                      //     .state
                      //     .updatedAuthorStyle
                      //     .authorAlignment,
                      onChanged: (value) {
                        context.read<AuthorBloc>().add(
                            AuthorAlignmentChangedEvent(newAlignment: value!));
                      },
                      underline: const SizedBox(),
                      items: QuoteStylingValues.authorAlignments.keys
                          .map((Alignment value) {
                        return DropdownMenuItem<Alignment>(
                          value: value,
                          child: Text(
                            QuoteStylingValues.authorAlignments[value]!,
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
