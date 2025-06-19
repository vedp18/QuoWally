part of 'quote_list_bloc.dart';

abstract class QuoteListEvent {}

class LoadQuoteLists extends QuoteListEvent {}

class AddQuoteList extends QuoteListEvent {
  final QuoteList quoteList;
  // final String name;
  // final String filename;
  // final bool isPrebuilt;
  AddQuoteList({
    required this.quoteList,
    // required this.name,
    // required this.filename,
    // required this.isPrebuilt,
  });
}

class DeleteQuoteList extends QuoteListEvent {
  final QuoteList quoteList;
  // final String name;
  DeleteQuoteList({required this.quoteList});
}

class UpdateQuoteListQuotes extends QuoteListEvent {
  final QuoteList quoteList;
  // final String name;
  final List<StoredQuote> updatedQuotes;

  UpdateQuoteListQuotes({
    required this.quoteList,
    // required this.name,
    required this.updatedQuotes,
  });
}
