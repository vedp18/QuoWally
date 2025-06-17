import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/quote_bloc/quote_bloc.dart';
import 'package:quowally/utils/quowally_quotes.dart';

class QuotesListScreen extends StatelessWidget {
  final List<Map<String, String>> quotes = QuoWallyQuotes.quotes;

  QuotesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: const Text('Quotes'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: quotes.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final quote = quotes[index];

          return GestureDetector(
            onTap: () {
              context.read<QuoteBloc>().add(QuoteChangedEvent(
                  newQuoteText: quote['quote']!,
                  newAuthorText: quote['author'] ?? 'Unknown'));

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
                      quote['quote'] ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "- ${quote['author'] ?? ''}",
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
