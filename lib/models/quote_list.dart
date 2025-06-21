import 'dart:convert';

import 'package:quowally/models/stored_quote.dart';

class QuoteList {
  final String name;
  final bool isPrebuilt;
  final String filename;
  List<StoredQuote> quotes = [];
  int quoteIndex;

  QuoteList({
    required this.name,
    this.isPrebuilt = false,
    required this.filename,
    this.quoteIndex = 0,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'isPrebuilt': isPrebuilt,
      'filename': filename,
      'quoteIndex': quoteIndex,
    };
  }

  factory QuoteList.fromMap(Map<String, dynamic> map) {
    return QuoteList(
      name: (map["name"] ?? '') as String,
      isPrebuilt: (map["isPrebuilt"] ?? false) as bool,
      filename: (map["filename"] ?? '') as String,
      quoteIndex: (map["quoteIndex"] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuoteList.fromJson(String source) => QuoteList.fromMap(json.decode(source) as Map<String, dynamic>);



  int getAndIncrementIndex() {
    int current = quoteIndex;
    quoteIndex = (quoteIndex + 1) % quotes.length;
    return current;
  }

  resetQuoteIndex() {

    quoteIndex = 0;

    // final box = await Hive.openBox('auto_change');
    // await box.put('quote_index', 0);
  }


}
