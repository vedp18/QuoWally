import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/quote_bloc/quote_bloc.dart';
import 'package:quowally/blocs/quote_list_bloc/quote_list_bloc.dart';
import 'package:quowally/models/quote_list.dart';
import 'package:quowally/models/stored_quote.dart';
import 'package:quowally/ui/screens/home_screen.dart';

class FavouriteQuotesScreen extends StatelessWidget {
  const FavouriteQuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Text("Favourite Quotes"),
        centerTitle: true,
      ),
      body: BlocBuilder<QuoteListBloc, QuoteListState>(
        builder: (context, state) {
          // find updated versions of StoredQuotes from bloc state
          final favouriteQuotes = state.lists
              .expand((list) => list.quotes // flatten all lists of quotes
                  .where((quote) => quote.isFavourite) // filter only favourites
                  .map(
                    (quote) => {'quoteList': list, 'quote': quote},
                  ))
              .toList();

          if (favouriteQuotes.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 30,
              ),
              child: Text(
                "No Quotes added yet. ",
                style: TextStyle(
                  color: Colors.brown[100],
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            itemCount: favouriteQuotes.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final quote = favouriteQuotes[index]['quote'] as StoredQuote;
              final quoteList =
                  favouriteQuotes[index]['quoteList'] as QuoteList;

              return GestureDetector(
                onTap: () {
                  // Adding QuoteChangedEvent to QuoteBloc
                  context.read<QuoteBloc>().add(
                        QuoteChangedEvent(
                          newAuthorText: quote.authorText,
                          newQuoteText: quote.quoteText,
                        ),
                      );

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
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.brown[100]!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row: Quote + Heart button
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Quote text
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 12.0,
                                right: 12.0,
                                top: 12.0,
                                bottom: 8,
                              ),
                              child: Text(
                                quote.quoteText,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),

                          // Add to Favorite or Heart button
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: Icon(
                              quote.isFavourite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: quote.isFavourite ? Colors.red : null,
                            ),
                            onPressed: () {
                              context.read<QuoteListBloc>().add(
                                    ToggleFavouriteQuoteEvent(
                                      quoteList: quoteList,
                                      quote: quote,
                                    ),
                                  );

                              // SnackBar to show Quote added to Favourites
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(milliseconds: 630),
                                  elevation: 5,
                                  backgroundColor: Colors.brown[50],
                                  behavior: SnackBarBehavior.floating,
                                  width: 300,
                                  // margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  // backgroundColor: ,
                                  content: Center(
                                    child: Text(
                                      !quote.isFavourite
                                          ? "Quote added to Favourites"
                                          : "Quote removed from Favourites",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      // Author aligned to extreme right of card
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0, bottom: 7),
                          child: Text(
                            "- ${quote.authorText}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
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
