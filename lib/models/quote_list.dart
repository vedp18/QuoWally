// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:quowally/models/stored_quote.dart';

part 'quote_list.g.dart';

@HiveType(typeId: 1) // <-- make sure this ID is unique in your project
class QuoteList extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final bool isPrebuilt;

  @HiveField(2)
  final String filename;

  @HiveField(3)
  List<StoredQuote> quotes;

  @HiveField(4)
  int quoteIndex;

  QuoteList({
    required this.name,
    this.isPrebuilt = false,
    required this.filename,
    this.quoteIndex = 0,
    required this.quotes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'isPrebuilt': isPrebuilt,
      'filename': filename,
      'quotes': quotes.map((x) {
        return x.toMap();
      }).toList(growable: false),
      'quoteIndex': quoteIndex,
    };
  }

  factory QuoteList.fromMap(Map<String, dynamic> map) {
    return QuoteList(
      name: (map["name"] ?? '') as String,
      isPrebuilt: (map["isPrebuilt"] ?? false) as bool,
      filename: (map["filename"] ?? '') as String,
      quotes: List<StoredQuote>.from(
        ((map['quotes'] ?? const []) as List).map<StoredQuote>((x) {
          final safeMap = ((x ?? {}) as Map).map(
            (k, v) => MapEntry(k.toString(), v),
          );
          return StoredQuote.fromMap(safeMap);
        }),
      ),
      quoteIndex: (map["quoteIndex"] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuoteList.fromJson(String source) =>
      QuoteList.fromMap(json.decode(source) as Map<String, dynamic>);

  // int getAndIncrementIndex() {
  //   int current = quoteIndex;
  //   quoteIndex = (quoteIndex + 1) % quotes.length;
  //   return current;
  // }

  // resetQuoteIndex() {
  //   quoteIndex = 0;
  // }
}
