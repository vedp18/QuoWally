// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'quote_bloc.dart';

@immutable
class QuoteState {
  final Quote updatedQuote;

  const QuoteState({required this.updatedQuote});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'updatedQuote': updatedQuote.toMap(),
    };
  }

  factory QuoteState.fromMap(Map<String, dynamic> map) {
    return QuoteState(
      updatedQuote: Quote.fromMap((map["updatedQuote"] ??
          Map<String, dynamic>.from({})) as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuoteState.fromJson(String source) =>
      QuoteState.fromMap(json.decode(source) as Map<String, dynamic>);
}
