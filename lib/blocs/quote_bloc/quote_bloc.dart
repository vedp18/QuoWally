import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quote_wallpaper_app/models/author_style.dart';
import 'package:flutter_quote_wallpaper_app/models/quote.dart';
import 'package:flutter_quote_wallpaper_app/models/quote_style.dart';

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  QuoteBloc() : super(QuoteInitial()) {
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
    final Quote currentQuote = _getCurrentQuote(state);
    final updatedQuote = currentQuote.copyWith(quote: event.newQuoteText, author: event.newAuthorText);
    emit(QuoteUpdated(updatedQuote: updatedQuote));
  }

  // changing quote color
  void _onQuoteColorChangedEvent(
    QuoteColorChangedEvent event,
    Emitter<QuoteState> emit,
  ) {
    final Quote currentQuote = _getCurrentQuote(state);

    final updatedStyle =
        currentQuote.quoteStyle.copyWith(quoteColor: event.newColor);

    emit(QuoteUpdated(
        updatedQuote: currentQuote.copyWith(quoteStyle: updatedStyle)));
  }

  // changing quote font
  void _onQuoteFontChangedEvent(
    QuoteFontChangedEvent event,
    Emitter<QuoteState> emit,
  ) {
    final Quote currentQuote = _getCurrentQuote(state);

    final updatedStyle =
        currentQuote.quoteStyle.copyWith(quoteFont: event.newFont);

    emit(QuoteUpdated(
        updatedQuote: currentQuote.copyWith(quoteStyle: updatedStyle)));
  }

  // changing quote font style
  void _onQuoteFontStyleChangedEvent(
    QuoteFontStyleChangedEvent event,
    Emitter<QuoteState> emit,
  ) {
    final Quote currentQuote = _getCurrentQuote(state);

    final updatedStyle =
        currentQuote.quoteStyle.copyWith(quoteFontStyle: event.newFontStyle);

    emit(QuoteUpdated(
        updatedQuote: currentQuote.copyWith(quoteStyle: updatedStyle)));
  }

  // changing quote size
  void _onQuoteSizeChangedEvent(
    QuoteSizeChangedEvent event,
    Emitter<QuoteState> emit,
  ) {
    final Quote currentQuote = _getCurrentQuote(state);

    final updatedStyle =
        currentQuote.quoteStyle.copyWith(quoteSize: event.newSize);

    emit(QuoteUpdated(
        updatedQuote: currentQuote.copyWith(quoteStyle: updatedStyle)));
  }

  // changing quote size
  void _onQuoteWeightChangedEvent(
    QuoteWeightChangedEvent event,
    Emitter<QuoteState> emit,
  ) {
    final Quote currentQuote = _getCurrentQuote(state);

    final updatedStyle =
        currentQuote.quoteStyle.copyWith(quoteWeight: event.newWeight);

    emit(QuoteUpdated(
        updatedQuote: currentQuote.copyWith(quoteStyle: updatedStyle)));
  }

  // changing quote alignment
  void _onQuoteAlignmentChangedEvent(
    QuoteAlignmentChangedEvent event,
    Emitter<QuoteState> emit,
  ) {
    final Quote currentQuote = _getCurrentQuote(state);

    final updatedStyle =
        currentQuote.quoteStyle.copyWith(quoteAlignment: event.newAlignment);

    emit(QuoteUpdated(
        updatedQuote: currentQuote.copyWith(quoteStyle: updatedStyle)));
  }

  // helper method to get current Quote with its properties
  Quote _getCurrentQuote(QuoteState state) {
    if (state is QuoteInitial) return state.quote;
    if (state is QuoteUpdated) return state.updatedQuote;
    throw Exception("Unknow QuoteState - $state");
  }
}
