part of 'quote_list_bloc.dart';


class QuoteListState {
  final List<QuoteList> lists;

  QuoteListState({required this.lists});

  factory QuoteListState.initial() {
    return QuoteListState(lists: [
      QuoteList(name: 'QuoWally Quotes', isPrebuilt: true, filename: 'quowallyquotes.json'),
      QuoteList(name: 'Motivational', isPrebuilt: true, filename: 'motivational.json'),
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
