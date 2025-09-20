import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/quote_bloc/quote_bloc.dart';
import 'package:quowally/blocs/quote_list_bloc/quote_list_bloc.dart';
import 'package:quowally/models/quote_list.dart';
import 'package:quowally/models/stored_quote.dart';
import 'package:quowally/ui/screens/home_screen.dart';
import 'package:quowally/ui/widgets/common/quote_card.dart';

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
                child: QuoteCard(quote: quote, quoteList: quoteList),
              );
            },
          );
        },
      ),
    );
  }
}
