part of 'quote_list_bloc.dart';

enum QuoteListStatus { idle, loading, success, failure }

class QuoteListState {
  final List<QuoteList> lists;
  final QuoteListStatus quoteListStatus;

  QuoteListState({
    required this.lists,
    this.quoteListStatus = QuoteListStatus.idle,
  });

  factory QuoteListState.initial() {
    return QuoteListState(
      lists: [
        QuoteList(
            name: "Select List", filename: "", quotes: [], isPrebuilt: true),
        // QuoteList(name: 'QuoWally Quotes', isPrebuilt: true, filename: 'assets/quotes/quowallyquotes.json'),
        // QuoteList(name: 'Motivational Quotes', isPrebuilt: true, filename: 'assets/quotes/motivationalquotes.json'),
        // QuoteList(name: 'Smart Quotes', isPrebuilt: true, filename: 'assets/quotes/smartquotes.json'),
        // QuoteList(name: 'Love', isPrebuilt: true, filename: 'love.json'),
        // QuoteList(name: 'Wisdom', isPrebuilt: true, filename: 'wisdom.json'),
      ],
      quoteListStatus: QuoteListStatus.idle,
    );
  }

  Map<String, dynamic> toJson() => {
        'lists': lists.map((e) => e.toJson()).toList(),
        'quoteListStatus': quoteListStatus.name,
      };

  factory QuoteListState.fromJson(Map<String, dynamic> json) {
    final raw = json['lists'] as List<dynamic>;
    return QuoteListState(
      lists: raw.map((e) => QuoteList.fromJson(e)).toList(),
      quoteListStatus: QuoteListStatus.values.firstWhere(
        (status) => status.name == (json['quoteListStatus'] ?? 'idle'),
        orElse: () => QuoteListStatus.idle,
      ),
    );
  }

  QuoteListState copyWith({
    List<QuoteList>? lists,
    QuoteListStatus? quoteListStatus,
  }) {
    return QuoteListState(
      lists: lists ?? this.lists,
      quoteListStatus: quoteListStatus ?? this.quoteListStatus,
    );
  }
}
