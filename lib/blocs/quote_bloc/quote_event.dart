part of 'quote_bloc.dart';

@immutable
sealed class QuoteEvent {}

final class QuoteChangedEvent extends QuoteEvent {
  final String newQuoteText;

  QuoteChangedEvent({required this.newQuoteText});
}

final class QuoteColorChangedEvent extends QuoteEvent {
  final Color newColor;

  QuoteColorChangedEvent({required this.newColor});
}

final class QuoteFontChangedEvent extends QuoteEvent {
  final String newFont;

  QuoteFontChangedEvent({required this.newFont});
}

final class QuoteFontStyleChangedEvent extends QuoteEvent {
  final FontStyle newFontStyle;

  QuoteFontStyleChangedEvent({required this.newFontStyle});
}

final class QuoteSizeChangedEvent extends QuoteEvent {
  final double newSize;

  QuoteSizeChangedEvent({required this.newSize});
}

final class QuoteWeightChangedEvent extends QuoteEvent {
  final FontWeight newWeight;

  QuoteWeightChangedEvent({required this.newWeight});
}

final class QuoteAlignmentChangedEvent extends QuoteEvent {
  final TextAlign newAlignment;

  QuoteAlignmentChangedEvent({required this.newAlignment});
}
