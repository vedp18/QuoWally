import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/quote_bloc/quote_bloc.dart';
import 'package:quowally/models/quote_list.dart';
import 'package:quowally/utils/quowally_quotes.dart';

class QuotesListScreen extends StatelessWidget {

  final QuoteList quoteList; 
  
  final List<Map<String, String>> quotes = QuoWallyQuotes.quotes;

  QuotesListScreen({super.key, required this.quoteList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Text(quoteList.name),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: quoteList.quotes.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final quote = quoteList.quotes[index];

          return GestureDetector(
            onTap: () {
              context.read<QuoteBloc>().add(QuoteChangedEvent(
                  newQuoteText: quote.quoteText,
                  newAuthorText: quote.authorText));

              Navigator.pop(context);

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

              // showModalBottomSheet(
              //   context: context,
              //   builder: (context) => Container(
              //     padding: EdgeInsets.all(10),
              //     child: Center(
              //       child: Text(
              //         "Quote Updated",
              //         style: TextStyle(fontSize: 22),
              //       ),
              //     ),
              //   ),
              // );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.brown[100]!),
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8),
              elevation: 0,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      quote.quoteText,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "- ${quote.authorText}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
