import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quowally/blocs/auto_change_quote_bloc/auto_change_quote_bloc.dart';
import 'package:quowally/ui/widgets/copy_share_row.dart';
import 'package:quowally/ui/widgets/qoute_styling_list_tile.dart';
import 'package:quowally/ui/widgets/quote_preview.dart';

class AutoChangeConfigScreen extends StatelessWidget {
  const AutoChangeConfigScreen({super.key});

  final Color _backgroundColor = Colors.white;

  // void _toggleAutoChange(bool value) {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.brown[800],
        titleTextStyle: GoogleFonts.charm(
          textStyle: TextStyle(
            color: Colors.brown[800],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        title: const Text("Auto Change Quote"),
        actions: [
          BlocBuilder<AutoChangeQuoteBloc, AutoChangeQuoteState>(
            builder: (context, state) {
              return FlutterSwitch(
                width: 45,
                height: 23,
                toggleSize: 15,
                activeColor: Colors.brown,
                inactiveColor: Colors.grey,
                value: state.isEnabled,
                onToggle: (value) {
                  // final QuoteList selectedQuoteList = context.read<AutoChangeQuoteBloc>().state.selectedQuoteList;
                  // final int index = selectedQuoteList.getAndIncrementIndex();
                  // final quote = selectedQuoteList.quotes[index];

                  // context.read<QuoteBloc>().add(QuoteChangedEvent(newAuthorText: quote.authorText, newQuoteText: quote.quoteText));

                  // final Quote currentQuote =
                  //     context.read<QuoteBloc>().state.updatedQuote;
                  // currentQuote.authorStyle =
                  //     context.read<AuthorBloc>().state.updatedAuthorStyle;
                  // final currentWallpaper =
                  //     context.read<WallpaperBloc>().state.wallpaper;
                  // currentWallpaper.quote = currentQuote;

                  context
                      .read<AutoChangeQuoteBloc>()
                      .add(ToggleAutoChange(isEnabled: value));
                },
              );
            },
          ),
          SizedBox(
            width: 30,
          ),
        ],
      ),
      body: BlocBuilder<AutoChangeQuoteBloc, AutoChangeQuoteState>(
        builder: (context, state) {
          return AbsorbPointer(
            absorbing: !state.isEnabled, // disable interactivity
            child: Opacity(
              opacity: state.isEnabled ? 1.0 : 0.5, // dim when disabled
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Quote Preview
                    QuotePreview(),

                    // Row --> copy and share
                    CopyShareRow(),

                    // Quote Styling
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6.0),
                        child: QuoteStylingList(
                          fromAutoChange: true,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(270, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onPressed: () {
                          context.read<AutoChangeQuoteBloc>().add(ToggleAutoChange(isEnabled: state.isEnabled));
                        },
                        child: Text(
                          "Save Changes",
                          style: GoogleFonts.andika(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
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
