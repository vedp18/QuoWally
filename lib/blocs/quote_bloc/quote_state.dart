part of 'quote_bloc.dart';

@immutable
sealed class QuoteState {}

final class QuoteInitial extends QuoteState {
  final Quote quote = Quote(
    quote: "He who will not economize will have to agonize",
    // "11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111",
    // "ॐ असतो मा सद्गमय ।\nतमसो मा ज्योतिर्गमय ।\nमृत्योर्मा अमृतं गमय ।\nॐ शान्तिः शान्तिः शान्तिः ॥",
    author: "Brihadaranyaka Upanishad",
    quoteStyle: QuoteStyle(),
  );

  QuoteInitial();
}

final class QuoteUpdated extends QuoteState {
  final Quote updatedQuote;

  QuoteUpdated({required this.updatedQuote});
}
