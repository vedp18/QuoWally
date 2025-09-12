part of 'quote_list_bloc.dart';

abstract class QuoteListEvent {}

class ToggleFavouriteQuoteEvent extends QuoteListEvent {
  final QuoteList quoteList;
  final StoredQuote quote;

  ToggleFavouriteQuoteEvent({required this.quoteList, required this.quote});
}

class SyncQuoteListsEvent extends QuoteListEvent {}

class AddQuoteList extends QuoteListEvent {
  final QuoteList quoteList;
  AddQuoteList({
    required this.quoteList,
  });
}

class DeleteQuoteList extends QuoteListEvent {
  final QuoteList quoteList;
  DeleteQuoteList({required this.quoteList});
}

class UpdateQuoteListQuotes extends QuoteListEvent {
  final QuoteList quoteList;
  final List<StoredQuote> updatedQuotes;

  UpdateQuoteListQuotes({
    required this.quoteList,
    required this.updatedQuotes,
  });
}
