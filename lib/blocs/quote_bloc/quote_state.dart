part of 'quote_bloc.dart';

@immutable
class QuoteState {

  final Quote updatedQuote;

  const QuoteState({required this.updatedQuote});
}

// final class QuoteInitial extends QuoteState {
//   final Quote quote = Quote(
//     quote: 
//     "He who will not economize will have to agonize.",
//     // "11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111",
//     // "ॐ असतो मा सद्गमय ।\nतमसो मा ज्योतिर्गमय ।\nमृत्योर्मा अमृतं गमय ।\nॐ शान्तिः शान्तिः शान्तिः ॥",
//     author: "Brihadaranyaka Upanishad",
//     quoteStyle: QuoteStyle(),
//     authorStyle: AuthorStyle(),
//   );

//   QuoteInitial();
// }

// final class QuoteUpdated extends QuoteState {

//   QuoteUpdated({required this.updatedQuote});
// }
