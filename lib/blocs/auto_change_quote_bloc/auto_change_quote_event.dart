part of 'auto_change_quote_bloc.dart';

@immutable
sealed class AutoChangeQuoteEvent {}

class ToggleAutoChange extends AutoChangeQuoteEvent {
  final bool enabled;
  ToggleAutoChange({required this.enabled});
}

class UpdateQuoteList extends AutoChangeQuoteEvent {
  final QuoteList newQuoteList;
  // final String listId;
  UpdateQuoteList({required this.newQuoteList});
}

class UpdateInterval extends AutoChangeQuoteEvent {
  final Duration interval;
  UpdateInterval({required this.interval});
}

class UpdateScreen extends AutoChangeQuoteEvent {
  final int screen;
  UpdateScreen({required this.screen});
}
