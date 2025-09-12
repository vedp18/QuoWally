import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/author_bloc/author_bloc.dart';
import 'package:quowally/blocs/quote_bloc/quote_bloc.dart';
import 'package:quowally/blocs/wallpaper_bloc/wallpaper_bloc.dart';
import 'package:quowally/models/author_style.dart';
import 'package:quowally/models/quote.dart';

class QuotePreview extends StatelessWidget {
  const QuotePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WallpaperBloc, WallpaperState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            maxHeight: 360, // preview max height
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: state.wallpaper.wallpaperColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: BlocBuilder<QuoteBloc, QuoteState>(
            builder: (context, state) {
              final Quote currentQuote = state.updatedQuote;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quote Text
                    Text(
                      currentQuote.quote,
                      style: TextStyle(
                        fontFamily: currentQuote.quoteStyle.quoteFont,
                        height: 1.2,
                        fontSize: currentQuote.quoteStyle.quoteSize,
                        fontStyle: currentQuote.quoteStyle.quoteFontStyle,
                        fontWeight: currentQuote.quoteStyle.quoteWeight,
                        color: currentQuote.quoteStyle.quoteColor,
                      ),
                      textAlign: currentQuote.quoteStyle.quoteAlignment,
                      textDirection: TextDirection.ltr,
                    ),

                    const SizedBox(height: 6),

                    // Author Text
                    BlocBuilder<AuthorBloc, AuthorState>(
                      builder: (context, state) {
                        final AuthorStyle currentAuthorStyle =
                            state.updatedAuthorStyle;
                        return Align(
                          alignment: currentAuthorStyle.authorAlignment,
                          child: Text(
                            "-  ${currentQuote.author}",
                            style: TextStyle(
                              fontFamily: currentAuthorStyle.authorFont,
                              fontSize: currentAuthorStyle.authorSize,
                              fontStyle: currentAuthorStyle.authorFontStyle,
                              fontWeight: currentAuthorStyle.authorWeight,
                              color: currentQuote.quoteStyle.quoteColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
