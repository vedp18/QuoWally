import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/quote_bloc/quote_bloc.dart';
import 'package:quowally/blocs/quote_list_bloc/quote_list_bloc.dart';
import 'package:quowally/models/quote_list.dart';
import 'package:quowally/models/stored_quote.dart';
import 'package:quowally/ui/widgets/add_custom_quote.dart';

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
                        );

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

          return ListView.builder(
            itemCount: quotes.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final quote = quotes[index];

              return Card(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.brown[100]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.symmetric(vertical: 8),
                elevation: 0,
                child: ListTile(
                  onTap: () {
                    context.read<QuoteBloc>().add(
                          QuoteChangedEvent(
                            newQuoteText: quote.quoteText,
                            newAuthorText: quote.authorText,
                          ),
                        );

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(milliseconds: 540),
                        elevation: 5,
                        backgroundColor: Colors.brown[50],
                        behavior: SnackBarBehavior.floating,
                        width: 200,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        content: const Center(
                          child: Text(
                            "Quote Updated",
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ),
                    );
                  },
                  title: Text(
                    quote.quoteText,
                    style: const TextStyle(fontSize: 16),
                  ),
                  subtitle: Text(
                    "- ${quote.authorText}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Favorite button
                      IconButton(
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -2),
                        icon: Icon(
                          false ? Icons.favorite : Icons.favorite_border,
                          color: false ? Colors.red : null,
                        ),
                        onPressed: () {
                          // final updatedQuotes = List<StoredQuote>.from(
                          //     updatedList.quotes); // copy
                          // final indexInList = updatedList.quotes.indexOf(quote);

                          // toggle favorite
                          // updatedQuotes[indexInList] = quote.copyWith(
                          //   isFavorite: !quote.isFavorite,
                          // );

                          //   context.read<QuoteListBloc>().add(
                          //         UpdateQuoteListQuotes(
                          //           quoteList: updatedList,
                          //           updatedQuotes: updatedQuotes,
                          //         ),
                          //       );
                        },
                      ),
                      // Delete button
                      IconButton(
                        visualDensity:
                            VisualDensity(horizontal: -2, vertical: -2),
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          final updatedQuotes =
                              List<StoredQuote>.from(updatedList.quotes);
                          updatedQuotes.remove(quote);

                          context.read<QuoteListBloc>().add(
                                UpdateQuoteListQuotes(
                                  quoteList: updatedList,
                                  updatedQuotes: updatedQuotes,
                                ),
                              );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
