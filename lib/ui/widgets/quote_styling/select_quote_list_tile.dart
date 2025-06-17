import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/quote_bloc/quote_bloc.dart';
import 'package:quowally/utils/auto_change_quote_values.dart';
import 'package:quowally/utils/quote_styling_values.dart';

class SelectQuoteListTile extends StatelessWidget {
  const SelectQuoteListTile({super.key});

  final String quoteList = "Quowally Quote List";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Select Quote List: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown[500],
                fontSize: 11,
              ),
              children: [
                TextSpan(
                  text:
                      'Sets the quote list from which quote will be selected.',
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
              // alignment: WrapAlignment.spaceBetween,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // spacing: 14,
              children: [
                Text(
                  'Select Quote List:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[700],
                  ),
                ),
                DropdownButton2<String>(
                  buttonStyleData: ButtonStyleData(
                    width: 171,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    width: 150,
                    maxHeight: 300,
                  ),
                  isExpanded: true,
                  // menuWidth: 150,
                  value: quoteList,
                  // context
                  //     .read<QuoteBloc>()
                  //     .state
                  //     .updatedQuote
                  //     .quoteStyle
                  //     .quoteColor,
                  onChanged: (value) {},
                  underline: const SizedBox(),
                  items:
                      AutoChangeQuoteValues.quoteList.keys.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        // mainAxisSize: MainAxisSize.min,
                        spacing: 10,
                        children: [
                          Text(
                            AutoChangeQuoteValues.quoteList[value]!,
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
}
