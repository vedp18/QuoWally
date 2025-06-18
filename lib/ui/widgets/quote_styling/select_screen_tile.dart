import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/author_bloc/author_bloc.dart';
import 'package:quowally/blocs/auto_change_quote_bloc/auto_change_quote_bloc.dart';
import 'package:quowally/utils/auto_change_quote_values.dart';
import 'package:quowally/utils/quote_styling_values.dart';

class SelectScreenTile extends StatelessWidget {
  const SelectScreenTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Select Screen: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown[500],
                fontSize: 11,
              ),
              children: [
                TextSpan(
                  text:
                      'Select the screen where you want to auto change quote; i.e., LOCK_SCREEN',
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
                  'Screen:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[700],
                  ),
                ),
                BlocSelector<AutoChangeQuoteBloc, AutoChangeQuoteState, int>(
                  selector: (state) {
                    return state.screen;
                  },
                  builder: (context, state) {
                    return DropdownButton2<int>(
                      buttonStyleData: ButtonStyleData(
                        width: 171,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: 150,
                        maxHeight: 300,
                      ),
                      isExpanded: true,
                      // menuWidth: 200,
                      value: state,
                      //  context
                      //     .read<QuoteBloc>()
                      //     .state
                      //     .updatedQuote
                      //     .quoteStyle
                      //     .quoteAlignment,
                      onChanged: (value) {
                        context.read<AutoChangeQuoteBloc>().add(
                            UpdateScreen(screen: value!));
                      },
                      underline: const SizedBox(),
                      items: AutoChangeQuoteValues.screen.keys
                          .map((value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(
                            AutoChangeQuoteValues.screen[value]!,
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
