part of 'author_bloc.dart';

@immutable
class AuthorState {
  final AuthorStyle updatedAuthorStyle;

  const AuthorState({required this.updatedAuthorStyle});
}

// final class AuthorInitial extends AuthorState {
//   // final Quote quote = Quote(
//   //   quote: "He who will not economize will have to agonize",
//   //   // "11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111",
//   //   // "ॐ असतो मा सद्गमय ।\nतमसो मा ज्योतिर्गमय ।\nमृत्योर्मा अमृतं गमय ।\nॐ शान्तिः शान्तिः शान्तिः ॥",
//   //   author: "Brihadaranyaka Upanishad",
//   //   quoteStyle: QuoteStyle(),
//   // );

// }

// final class AuthorUpdated extends AuthorState {
//   AuthorUpdated({required this.updatedAuthor});
// }
