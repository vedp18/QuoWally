import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quote_wallpaper_app/blocs/quote_bloc/quote_bloc.dart';

class QuotesListScreen extends StatelessWidget {
  final List<Map<String, String>> quotes = [
    {
      'quote':
          "The best way to get started is to quit talking and begin doing.",
      'author': "Walt Disney"
    },
    {
      'quote':
          "ॐ असतो मा सद्गमय ।\nतमसो मा ज्योतिर्गमय ।\nमृत्योर्मा अमृतं गमय ।\nॐ शान्तिः शान्तिः शान्तिः ॥",
      'author': "Brihadaranyaka Upanishad"
    },
    {
      'quote': "Believe you can and you're halfway there.",
      'author': "Theodore Roosevelt"
    },
    {
      'quote':
          "Your time is limited, so don't waste it living someone else's life.",
      'author': "Steve Jobs"
    },
    {
      'quote':
          "The best way to get started is to quit talking and begin doing.",
      'author': "Walt Disney"
    },
    {
      'quote': "Success is not in what you have, but who you are.",
      'author': "Bo Bennett"
    },
    {
      'quote': "Success is not in what you have, but who you are.",
      'author': "Bo Bennett"
    },
    {
      'quote': "Believe you can and you're halfway there.",
      'author': "Theodore Roosevelt"
    },
    {
      'quote': "Success is not in what you have, but who you are.",
      'author': "Bo Bennett"
    },
    {
      'quote': "Success is not in what you have, but who you are.",
      'author': "Bo Bennett"
    },
  ];

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
