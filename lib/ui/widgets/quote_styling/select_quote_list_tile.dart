import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/auto_change_quote_bloc/auto_change_quote_bloc.dart';
import 'package:quowally/blocs/quote_list_bloc/quote_list_bloc.dart';
import 'package:quowally/models/quote_list.dart';

class SelectQuoteListTile extends StatelessWidget {
  const SelectQuoteListTile({super.key});

  // final String quoteList = "Quowally Quote List";

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
                BlocSelector<QuoteListBloc, QuoteListState, List<QuoteList>>(
                  selector: (state) {
                    return state.lists;
                  },
                  builder: (context, quoteLists) {
                    return BlocSelector<AutoChangeQuoteBloc,
                        AutoChangeQuoteState, QuoteList>(
                      selector: (state) {
                        return state.selectedQuoteList;
                      },
                      builder: (context, quoteList) {
                        print("selected: ${quoteList.name}");
                        return DropdownButton2<QuoteList>(
                          buttonStyleData: ButtonStyleData(
                            width: 171,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            width: 150,
                            maxHeight: 300,
                          ),
                          isExpanded: true,
                          // menuWidth: 150,
                          value: quoteLists.any((q) => q.name == quoteList.name)
                              ? quoteLists
                                  .firstWhere((q) => q.name == quoteList.name)
                              : quoteLists.first,

                          onChanged: (value) {
                            // final selectedQuoteList = quoteLists.firstWhere(
                            //   (q) => q.name == value,
                            // );
                            print(value!.name);
                            context.read<AutoChangeQuoteBloc>().add(
                                  UpdateQuoteList(newQuoteList: value),
                                );
                          },
                          underline: const SizedBox(),
                          items: quoteLists.map((quoteList) {
                            return DropdownMenuItem<QuoteList>(
                              value: quoteList,
                              child: Text(
                                quoteList.name,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            );
                          }).toList(),
                        );
                      },
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
