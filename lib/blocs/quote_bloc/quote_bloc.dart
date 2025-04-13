import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quote_wallpaper_app/models/author_style.dart';
import 'package:flutter_quote_wallpaper_app/models/quote.dart';
import 'package:flutter_quote_wallpaper_app/models/quote_style.dart';

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  // finalQuote quote = ;

  QuoteBloc()
      : super(
          QuoteState(
            updatedQuote: Quote(
              quote: "He who will not economize will have to agonize.",
              // "11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111",
              // "ॐ असतो मा सद्गमय ।\nतमसो मा ज्योतिर्गमय ।\nमृत्योर्मा अमृतं गमय ।\nॐ शान्तिः शान्तिः शान्तिः ॥",
              author: "Brihadaranyaka Upanishad",
              quoteStyle: QuoteStyle(),
              authorStyle: AuthorStyle(),
            ),
          ),
        ) {
    on<QuoteChangedEvent>(_onQuoteChangedEvent);
    on<QuoteColorChangedEvent>(_onQuoteColorChangedEvent);
    on<QuoteFontChangedEvent>(_onQuoteFontChangedEvent);
    on<QuoteFontStyleChangedEvent>(_onQuoteFontStyleChangedEvent);
    on<QuoteSizeChangedEvent>(_onQuoteSizeChangedEvent);
    on<QuoteWeightChangedEvent>(_onQuoteWeightChangedEvent);
    on<QuoteAlignmentChangedEvent>(_onQuoteAlignmentChangedEvent);
  }

  // changing quote
  void _onQuoteChangedEvent(
    QuoteChangedEvent event,
    Emitter<QuoteState> emit,
  ) {
    final Quote currentQuote = state.updatedQuote;
    final updatedQuote = currentQuote.copyWith(
        quote: event.newQuoteText, author: event.newAuthorText);
    emit(QuoteState(updatedQuote: updatedQuote));
  }

  // changing quote color
  void _onQuoteColorChangedEvent(
    QuoteColorChangedEvent event,
    Emitter<QuoteState> emit,
  ) {
    final Quote currentQuote = state.updatedQuote;

    final updatedStyle =
        currentQuote.quoteStyle.copyWith(quoteColor: event.newColor);

    emit(QuoteState(
        updatedQuote: currentQuote.copyWith(quoteStyle: updatedStyle)));
  }

  // changing quote font
  void _onQuoteFontChangedEvent(
    QuoteFontChangedEvent event,
    Emitter<QuoteState> emit,
  ) {
    final Quote currentQuote = state.updatedQuote;

    final updatedStyle =
        currentQuote.quoteStyle.copyWith(quoteFont: event.newFont);

    emit(QuoteState(
        updatedQuote: currentQuote.copyWith(quoteStyle: updatedStyle)));
  }

  // changing quote font style
  void _onQuoteFontStyleChangedEvent(
    QuoteFontStyleChangedEvent event,
    Emitter<QuoteState> emit,
  ) {
    final Quote currentQuote = state.updatedQuote;

    final updatedStyle =
        currentQuote.quoteStyle.copyWith(quoteFontStyle: event.newFontStyle);

    emit(QuoteState(
        updatedQuote: currentQuote.copyWith(quoteStyle: updatedStyle)));
  }

  // changing quote size
  void _onQuoteSizeChangedEvent(
    QuoteSizeChangedEvent event,
    Emitter<QuoteState> emit,
  ) {
    final Quote currentQuote = state.updatedQuote;

    final updatedStyle =
        currentQuote.quoteStyle.copyWith(quoteSize: event.newSize);

    emit(QuoteState(
        updatedQuote: currentQuote.copyWith(quoteStyle: updatedStyle)));
  }

  // changing quote size
  void _onQuoteWeightChangedEvent(
    QuoteWeightChangedEvent event,
    Emitter<QuoteState> emit,
  ) {
    final Quote currentQuote = state.updatedQuote;

    final updatedStyle =
        currentQuote.quoteStyle.copyWith(quoteWeight: event.newWeight);

    emit(QuoteState(
        updatedQuote: currentQuote.copyWith(quoteStyle: updatedStyle)));
  }

  // changing quote alignment
  void _onQuoteAlignmentChangedEvent(
    QuoteAlignmentChangedEvent event,
    Emitter<QuoteState> emit,
  ) {
    final Quote currentQuote = state.updatedQuote;

    final updatedStyle =
        currentQuote.quoteStyle.copyWith(quoteAlignment: event.newAlignment);

    emit(QuoteState(
        updatedQuote: currentQuote.copyWith(quoteStyle: updatedStyle)));
  }

  // helper method to get current Quote with its properties
  // Quote state.updatedQuotetate state) {
  //   return ;
  // }
}
