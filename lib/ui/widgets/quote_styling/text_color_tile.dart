import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quote_wallpaper_app/blocs/quote_bloc/quote_bloc.dart';
import 'package:flutter_quote_wallpaper_app/utils/quote_styling_values.dart';
import 'package:logger/logger.dart';



final Logger logger = Logger();
int count = 0; 

class TextColorTile extends StatelessWidget {
  const TextColorTile({super.key});

  @override
  Widget build(BuildContext context) {
    logger.d("TextColorTile build - ${++count}");
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
                BlocSelector<QuoteBloc, QuoteState, Color>(
                  selector: (state) {
                    return state.updatedQuote.quoteStyle.quoteColor;
                  },
                  builder: (context, quoteColor) {
                    return DropdownButton2<Color>(
                      buttonStyleData: ButtonStyleData(
                        width: 171,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: 150,
                        maxHeight: 300,
                      ),
                      isExpanded: true,
                      // menuWidth: 150,
                      value: quoteColor,
                      // context
                      //     .read<QuoteBloc>()
                      //     .state
                      //     .updatedQuote
                      //     .quoteStyle
                      //     .quoteColor,
                      onChanged: (value) {
                        context
                            .read<QuoteBloc>()
                            .add(QuoteColorChangedEvent(newColor: value!));
                      },
                      underline: const SizedBox(),
                      items: QuoteStylingValues.colors.keys.map((Color value) {
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
                                QuoteStylingValues.colors[value]!,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ],
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
