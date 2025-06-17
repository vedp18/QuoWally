part of 'auto_change_quote_bloc.dart';

@immutable
sealed class AutoChangeQuoteEvent {}

class ToggleAutoChange extends AutoChangeQuoteEvent {
  final bool enabled;
  ToggleAutoChange({required this.enabled});
}

class UpdateQuoteList extends AutoChangeQuoteEvent {
  final String listId;
  UpdateQuoteList({required this.listId});
}

class UpdateInterval extends AutoChangeQuoteEvent {
  final Duration interval;
  UpdateInterval({required this.interval});
}
