import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/quote_bloc/quote_bloc.dart';
import 'package:quowally/blocs/quote_list_bloc/quote_list_bloc.dart';
import 'package:quowally/ui/screens/quotes_list_screen.dart';
import 'package:quowally/ui/widgets/add_custom_quote.dart';
import 'package:quowally/utils/custom_logger.dart';

class SelectQuoteTile extends StatelessWidget {
  const SelectQuoteTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Select Quote: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown[500],
                fontSize: 11,
              ),
              children: [
                TextSpan(
                  text: 'Select quote from any List.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.brown[300],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: BlocConsumer<QuoteListBloc, QuoteListState>(
              listener: (context, state) {
                // Debug log whenever list count changes
                CustomLogger.logToFile(
                    "Updated lists: ${state.lists.map((l) => l.name).toList()}");
              },
              builder: (context, state) {
                // Getting current list of QuoteLists
                final quoteLists = state.lists;
                return Wrap(
                  spacing: 10,
                  children: [
                    // Custom Quote
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          padding: EdgeInsets.symmetric(horizontal: 7),
                          minimumSize: Size(0, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          side: BorderSide(color: Colors.brown[50]!)),
                      onPressed: () {
                        // Getting current quote text and author text
                        final String currentQuoteText =
                            context.read<QuoteBloc>().state.updatedQuote.quote;
                        final String currentAuthorText =
                            context.read<QuoteBloc>().state.updatedQuote.author;

                        // Dialog to set custom quote
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: AddCustomQuote(
                              currentQuote: currentQuoteText,
                              currentAuthor: currentAuthorText,
                              onSave: (context, quote, author) {
                                context.read<QuoteBloc>().add(
                                      QuoteChangedEvent(
                                        newQuoteText: quote,
                                        newAuthorText: author,
                                      ),
                                    );
                              },
                            ),
                          ),
                        );
                      },
                      child: Text("Custom Quote"),
                    ),

                    // dynamically generate list of quotes
                    ...quoteLists.skip(1).map((quoteList) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.symmetric(horizontal: 7),
                            minimumSize: Size(0, 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            side: BorderSide(color: Colors.brown[50]!)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  QuotesListScreen(quoteList: quoteList),
                            ),
                          );
                        },
                        child: Text(quoteList.name),
                      );
                    }),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
