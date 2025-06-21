part of 'auto_change_quote_bloc.dart';

@immutable
sealed class AutoChangeQuoteEvent {}

class ToggleAutoChange extends AutoChangeQuoteEvent {
  // final Wallpaper wallpaper;
  final bool isEnabled;
  // final BuildContext context;
  ToggleAutoChange({required this.isEnabled});
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
