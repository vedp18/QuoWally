import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/author_bloc/author_bloc.dart';
import 'package:quowally/blocs/quote_bloc/quote_bloc.dart';
import 'package:quowally/utils/quote_styling_values.dart';


class TextSizeTile extends StatelessWidget {
  const TextSizeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 10),
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
                  text: 'Sets the text size of the quote and author name.',
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
              // spacing: 9,   //? doesn't make sense since we have used spaceBetween
              children: [
                Text(
                  'Quote Text Size:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[700],
                  ),
                ),
                BlocSelector<QuoteBloc, QuoteState, double>(
                  selector: (state) {
                    return state.updatedQuote.quoteStyle.quoteSize;
                  },
                  builder: (context, quoteSize) {
                    return DropdownButton2<double>(
                      buttonStyleData: ButtonStyleData(
                        width: 171,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: 150,
                        maxHeight: 300,
                      ),
                      // menuMaxHeight: 300,
                      isExpanded: true,
                      // menuWidth: 200,
                      value: quoteSize,
                      // context
                      //     .read<QuoteBloc>()
                      //     .state
                      //     .updatedQuote
                      //     .quoteStyle
                      //     .quoteSize,
                      onChanged: (value) {
                        context
                            .read<QuoteBloc>()
                            .add(QuoteSizeChangedEvent(newSize: value!));
                      },
                      underline: const SizedBox(),
                      items: QuoteStylingValues.sizeValueToLabel.keys
                          .map((double value) {
                        return DropdownMenuItem<double>(
                          value: value,
                          child: Text(
                            QuoteStylingValues.sizeValueToLabel[value]!,
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

          // Author Text Size
          SizedBox(
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // spacing: 14,
              children: [
                Text(
                  'Author Text Size:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[700],
                  ),
                ),
                BlocSelector<AuthorBloc, AuthorState, double>(
                  selector: (state) {
                    return state.updatedAuthorStyle.authorSize;
                  },
                  builder: (context, authorSize) {
                    return DropdownButton2<double>(
                      buttonStyleData: ButtonStyleData(
                        width: 171,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: 150,
                        maxHeight: 300,
                      ),
                      // menuMaxHeight: 300,
                      isExpanded: true,
                      // menuWidth: 200,
                      value: authorSize, 
                      // context
                      //     .read<AuthorBloc>()
                      //     .state
                      //     .updatedAuthorStyle
                      //     .authorSize,
                      onChanged: (value) {
                        context
                            .read<AuthorBloc>()
                            .add(AuthorSizeChangedEvent(newSize: value!));
                      },
                      underline: const SizedBox(),
                      items: QuoteStylingValues.sizeValueToLabel.keys
                          .map((double value) {
                        return DropdownMenuItem<double>(
                          value: value,
                          child: Text(
                            QuoteStylingValues.sizeValueToLabel[value]!,
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
