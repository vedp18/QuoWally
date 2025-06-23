import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/auto_change_quote_bloc/auto_change_quote_bloc.dart';
import 'package:quowally/utils/auto_change_quote_values.dart';

class UpdateQuoteInterval extends StatelessWidget {
  const UpdateQuoteInterval({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Select quote change interval: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown[500],
                fontSize: 11,
              ),
              children: [
                TextSpan(
                  text:
                      'Updates the quote after selected time interval.',
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
                  'Quote Change Interval:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[700],
                  ),
                ),
                BlocSelector<AutoChangeQuoteBloc, AutoChangeQuoteState, Duration>(
                  selector: (state) {
                    return state.interval;
                  },
                  builder: (context, interval) {
                    
                    return DropdownButton2<Duration>(
                      buttonStyleData: ButtonStyleData(
                        width: 171,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: 150,
                        maxHeight: 300,
                      ),
                      isExpanded: true,
                      // menuWidth: 150,
                      value: interval,
                      // context
                      //     .read<QuoteBloc>()
                      //     .state
                      //     .updatedQuote
                      //     .quoteStyle
                      //     .quoteColor,
                      onChanged: (value) {
                        context
                            .read<AutoChangeQuoteBloc>()
                            .add(UpdateInterval(interval: value!));
                      },
                      underline: const SizedBox(),
                      items: AutoChangeQuoteValues.quoteChangeInterval.keys.map((Duration value) {
                        return DropdownMenuItem<Duration>(
                          value: value,
                          child:
                              Text(
                                AutoChangeQuoteValues.quoteChangeInterval[value]!,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
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
