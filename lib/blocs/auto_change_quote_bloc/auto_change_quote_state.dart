// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auto_change_quote_bloc.dart';

class AutoChangeQuoteState {
  final bool isEnabled;
  final Duration interval;
  final QuoteList selectedQuoteList;
  final int screen;
  final QuoteList? lastSelectedList;
  // final String selectedQuoteList;

  AutoChangeQuoteState(
      {required this.isEnabled,
      required this.interval,
      required this.selectedQuoteList,
      required this.screen,
      this.lastSelectedList});

  factory AutoChangeQuoteState.initial() {
    return AutoChangeQuoteState(
      isEnabled: false,
      interval: const Duration(minutes: 15),
      selectedQuoteList:
          QuoteList(name: "QuoWally Quotes", filename: "quowallyquotes.json"),
      screen: 2,
      lastSelectedList:
          QuoteList(name: "QuoWally Quotes", filename: "quowallyquotes.json"),
    );
  }

  // AutoChangeQuoteState copyWith({
  //   bool? isEnabled,
  //   Duration? interval,
  //   QuoteList? selectedQuoteList,
  // }) {
  //   return AutoChangeQuoteState(
  //     isEnabled: isEnabled ?? this.isEnabled,
  //     interval: interval ?? this.interval,
  //     selectedQuoteList: selectedQuoteList ?? this.selectedQuoteList,
  //   );
  // }

  AutoChangeQuoteState copyWith({
    bool? isEnabled,
    Duration? interval,
    QuoteList? selectedQuoteList,
    int? screen,
    QuoteList? lastSelectedList,
  }) {
    return AutoChangeQuoteState(
      isEnabled: isEnabled ?? this.isEnabled,
      interval: interval ?? this.interval,
      selectedQuoteList: selectedQuoteList ?? this.selectedQuoteList,
      screen: screen ?? this.screen,
      lastSelectedList: lastSelectedList ?? this.lastSelectedList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isEnabled': isEnabled,
      'intervalInHour': interval.inHours,
      'selectedQuoteList': selectedQuoteList.toMap(),
      'screen': screen,
      'lastSelectedList': lastSelectedList!.toMap(),
    };
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'isEnabled': isEnabled,
  //     'intervalInHours': interval.inHours,
  //     'selectedQuoteList': selectedQuoteList,
  //   };
  // }

  factory AutoChangeQuoteState.fromMap(Map<String, dynamic> map) {
    return AutoChangeQuoteState(
      isEnabled: (map["isEnabled"] ?? false) as bool,
      interval: Duration(hours: map['intervalInHours'] ?? 1),
      selectedQuoteList: QuoteList.fromMap((map["selectedQuoteList"] ??
          Map<String, dynamic>.from({})) as Map<String, dynamic>),
      screen: (map["screen"] ?? 1) as int,
      lastSelectedList: QuoteList.fromMap((map["lastSelectedList"] ??
          Map<String, dynamic>.from({})) as Map<String, dynamic>),
    );
  }

  // factory AutoChangeQuoteState.fromMap(Map<String, dynamic> map) {
  //   return AutoChangeQuoteState(
  //     isEnabled: map['isEnabled'] ?? false,
  //     interval: Duration(hours: map['intervalInHours'] ?? 1),
  //     selectedQuoteList: map['selectedQuoteList'] ?? "QuoWally Quotes",
  //   );
  // }

  String toJson() => json.encode(toMap());

  factory AutoChangeQuoteState.fromJson(String source) =>
      AutoChangeQuoteState.fromMap(json.decode(source) as Map<String, dynamic>);
}
