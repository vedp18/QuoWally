import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/quote_bloc/quote_bloc.dart';
import 'package:quowally/blocs/quote_list_bloc/quote_list_bloc.dart';
import 'package:quowally/models/quote_list.dart';
import 'package:quowally/models/stored_quote.dart';
import 'package:quowally/ui/screens/home_screen.dart';
import 'package:quowally/ui/widgets/add_custom_quote.dart';
import 'package:quowally/ui/widgets/common/quote_card.dart';

class QuotesListScreen extends StatelessWidget {
  final QuoteList quoteList;

  const QuotesListScreen({super.key, required this.quoteList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Text(quoteList.name),
        actions: [
          if (!quoteList.isPrebuilt)
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: AddCustomQuote(
                      onSave: (context, quote, author) {
                        final storedQuote = StoredQuote(
                            quoteText: quote,
                            authorText: author,
                            isFavourite: false);

                        // Get the latest version from bloc
                        final currentList = context
                            .read<QuoteListBloc>()
                            .state
                            .lists
                            .firstWhere(
                              (list) => list.name == quoteList.name,
                              orElse: () => quoteList,
                            );

                        // Work with its quotes
                        final updatedQuotes =
                            List<StoredQuote>.from(currentList.quotes)
                              ..add(storedQuote);

                        context.read<QuoteListBloc>().add(
                              UpdateQuoteListQuotes(
                                quoteList: currentList,
                                updatedQuotes: updatedQuotes,
                              ),
                            );
                      },
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.add),
            ),
        ],
      ),
      body: BlocBuilder<QuoteListBloc, QuoteListState>(
        builder: (context, state) {
          // find updated version of this list from bloc state
          final updatedList = state.lists.firstWhere(
            (list) => list.name == quoteList.name,
            orElse: () => quoteList,
          );

          // sort in descending order (newest first)
          final quotes = List<StoredQuote>.from(updatedList.quotes.reversed);

          if (quotes.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 30,
              ),
              child: Text(
                "No Quotes added yet. \n Create through add button in Top-Right Corner.",
                style: TextStyle(
                  color: Colors.brown[100],
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            itemCount: quotes.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final quote = quotes[index];

              return GestureDetector(
                onTap: () {
                  // Adding QuoteChangedEvent to QuoteBloc
                  context.read<QuoteBloc>().add(QuoteChangedEvent(
                      newAuthorText: quote.authorText,
                      newQuoteText: quote.quoteText));

                  // removing all below screens and redirecting to HomeScreen
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => HomeScreen()),
                    (Route<dynamic> route) => false,
                  );

                  // SnackBar to show Quote Updated
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(milliseconds: 540),
                      elevation: 5,
                      backgroundColor: Colors.brown[50],
                      behavior: SnackBarBehavior.floating,
                      width: 200,
                      // margin: EdgeInsets.all(10),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      // backgroundColor: ,
                      content: Center(
                        child: Text(
                          "Quote Updated",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ),
                    ),
                  );
                },
                // Quote Card
                child: QuoteCard(quote: quote, quoteList: quoteList),
              );
            },
          );
        },
      ),
    );
  }
}
