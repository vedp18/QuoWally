import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/author_bloc/author_bloc.dart';
import 'package:quowally/blocs/quote_bloc/quote_bloc.dart';
import 'package:quowally/blocs/wallpaper_bloc/wallpaper_bloc.dart';
import 'package:quowally/models/author_style.dart';
import 'package:quowally/models/quote.dart';
import 'package:google_fonts/google_fonts.dart';

class QuotePreview extends StatelessWidget {
  const QuotePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WallpaperBloc, WallpaperState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          // width: physicalWd,
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: state.wallpaper.wallpaperColor,
            // color: Colors.brown[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: BlocBuilder<QuoteBloc, QuoteState>(
            builder: (context, state) {
              final Quote currentQuote = state.updatedQuote;

              return Column(
                spacing: 3,
                children: [
                  Text(
                    currentQuote.quote,
                    style: GoogleFonts.getFont(
                      currentQuote.quoteStyle.quoteFont,
                      textStyle: TextStyle(
                        height: 1.2,
                        fontSize: currentQuote.quoteStyle.quoteSize,
                        fontStyle: currentQuote.quoteStyle.quoteFontStyle,
                        fontWeight: currentQuote.quoteStyle.quoteWeight,
                        color: currentQuote.quoteStyle.quoteColor,
                      ),
                    ),
                    textAlign: currentQuote.quoteStyle.quoteAlignment,
                    textDirection: TextDirection.ltr,
                  ),

                  // Text(
                  //   currentQuote.quote,
                  //   style: GoogleFonts.tiroDevanagariSanskrit(
                  //       height: 1.2,
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w600,
                  //       color: Colors.brown[800]),
                  // ),
                  BlocBuilder<AuthorBloc, AuthorState>(
                    builder: (context, state) {
                      final AuthorStyle currentAuthorStyle =
                          state.updatedAuthorStyle;
                      return Align(
                        alignment: currentAuthorStyle.authorAlignment,
                        child: Text(
                          "-  ${currentQuote.author}",
                          style: GoogleFonts.getFont(
                            currentAuthorStyle.authorFont,
                            textStyle: TextStyle(
                              fontSize: currentAuthorStyle.authorSize,
                              fontStyle: currentAuthorStyle.authorFontStyle,
                              fontWeight: currentAuthorStyle.authorWeight,
                              color: currentQuote.quoteStyle.quoteColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
