part of 'quote_list_bloc.dart';


class QuoteListState {
  final List<QuoteList> lists;

  QuoteListState({required this.lists});

  factory QuoteListState.initial() {
    return QuoteListState(lists: [
      QuoteList(name: "Select List", filename: "", quotes: [], isPrebuilt: true),
      // QuoteList(name: 'QuoWally Quotes', isPrebuilt: true, filename: 'assets/quotes/quowallyquotes.json'),
      // QuoteList(name: 'Motivational Quotes', isPrebuilt: true, filename: 'assets/quotes/motivationalquotes.json'),
      // QuoteList(name: 'Smart Quotes', isPrebuilt: true, filename: 'assets/quotes/smartquotes.json'),
      // QuoteList(name: 'Love', isPrebuilt: true, filename: 'love.json'),
      // QuoteList(name: 'Wisdom', isPrebuilt: true, filename: 'wisdom.json'),
    ]);
  }

  Map<String, dynamic> toJson() => {
        'lists': lists.map((e) => e.toJson()).toList(),
      };

  factory QuoteListState.fromJson(Map<String, dynamic> json) {
    final raw = json['lists'] as List<dynamic>;
    return QuoteListState(
      lists: raw.map((e) => QuoteList.fromJson(e)).toList(),
    );
  }

  QuoteListState copyWith({List<QuoteList>? lists}) {
    return QuoteListState(lists: lists ?? this.lists);
  }
}
