part of 'auto_change_quote_bloc.dart';


class AutoChangeQuoteState {
  final bool isEnabled;
  final Duration interval;
  final String selectedQuoteList;

  AutoChangeQuoteState({
    required this.isEnabled,
    required this.interval,
    required this.selectedQuoteList,
  });

  factory AutoChangeQuoteState.initial() {
    return AutoChangeQuoteState(
      isEnabled: false,
      interval: const Duration(hours: 1),
      selectedQuoteList: "QuoWally Quotes",
    );
  }

  AutoChangeQuoteState copyWith({
    bool? isEnabled,
    Duration? interval,
    String? selectedQuoteList,
  }) {
    return AutoChangeQuoteState(
      isEnabled: isEnabled ?? this.isEnabled,
      interval: interval ?? this.interval,
      selectedQuoteList: selectedQuoteList ?? this.selectedQuoteList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isEnabled': isEnabled,
      'intervalInHours': interval.inHours,
      'selectedQuoteList': selectedQuoteList,
    };
  }

  factory AutoChangeQuoteState.fromMap(Map<String, dynamic> map) {
    return AutoChangeQuoteState(
      isEnabled: map['isEnabled'] ?? false,
      interval: Duration(hours: map['intervalInHours'] ?? 1),
      selectedQuoteList: map['selectedQuoteList'] ?? "QuoWally Quotes",
    );
  }
}
