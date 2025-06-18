part of 'quote_list_bloc.dart';

abstract class QuoteListEvent {}

class LoadQuoteLists extends QuoteListEvent {}

class AddQuoteList extends QuoteListEvent {
  final String name;
  final String filename;
  AddQuoteList(this.name, this.filename);
}

class DeleteQuoteList extends QuoteListEvent {
  final String name;
  DeleteQuoteList(this.name);
}
