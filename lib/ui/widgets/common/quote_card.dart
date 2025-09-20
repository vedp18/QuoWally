import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/models/quote_list.dart';
import 'package:quowally/models/stored_quote.dart';

import '../../../blocs/quote_list_bloc/quote_list_bloc.dart';

class QuoteCard extends StatefulWidget {
  final StoredQuote quote;
  final QuoteList quoteList;
  const QuoteCard({super.key, required this.quote, required this.quoteList});

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
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
                    widget.quote.quoteText,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),

              // Add to Favorite or Heart button
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 0,
                  children: [
                    // vspace
                    SizedBox(
                      height: 7,
                    ),

                    // Heart Button
                    IconButton(
                      visualDensity:
                          VisualDensity(vertical: -4, horizontal: -4),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        widget.quote.isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: widget.quote.isFavourite ? Colors.red : null,
                      ),
                      onPressed: () {
                        BlocProvider.of<QuoteListBloc>(context).add(
                          ToggleFavouriteQuoteEvent(
                            quoteList: widget.quoteList,
                            quote: widget.quote,
                          ),
                        );

                        // SnackBar to show Quote added to Favourites
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(milliseconds: 540),
                            // elevation: 5,
                            backgroundColor: Colors.brown[50],
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(
                                bottom: 20, left: 15, right: 15),
                            content: Center(
                              child: Text(
                                !widget.quote.isFavourite
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

                    // copy icon
                    IconButton(
                      visualDensity:
                          VisualDensity(vertical: -4, horizontal: -4),
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        final messenger = ScaffoldMessenger.of(context);
                        await Clipboard.setData(
                            ClipboardData(text: widget.quote.quoteText));
                        messenger.showSnackBar(
                          const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text("Quote copied to clipboard"),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.copy_rounded,
                        color: Colors.brown[400],
                      ),
                    ),
                  ],
                ),
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
                "- ${widget.quote.authorText}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
