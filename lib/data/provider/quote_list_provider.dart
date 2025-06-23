import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive/hive.dart';
// import 'package:quowally/models/quote.dart';
import 'package:quowally/models/quote_list.dart';
import 'package:quowally/models/stored_quote.dart';
import 'package:quowally/blocs/quote_list_bloc/quote_list_bloc.dart';

class QuoteListProvider {
  final QuoteListBloc quoteListBloc;

  QuoteListProvider(this.quoteListBloc);

  /// Load prebuilt list from assets and register in BLoC
  Future<QuoteList> loadPrebuiltQuoteList({
    required String name,
    required String filename,
  }) async {
    final String jsonStr = await rootBundle.loadString(filename);
    // print(jsonStr.length);
    final List<dynamic> jsonList = json.decode(jsonStr);
    // print(jsonList.first.toString());

    final quotes = jsonList.map((e) => StoredQuote.fromMap(e)).toList();
    // print("quotesLength: ${quotes.length}");
    // print(quotes.first.quoteText);

    final list = QuoteList(name: name, isPrebuilt: true, filename: filename, quotes: quotes);

    final existingIndex = quoteListBloc.state.lists.indexWhere(
      (l) => l.name == list.name && l.filename == list.filename && l.isPrebuilt,
    );

    if (existingIndex != -1) {
      // Replace quotes of the existing QuoteList
      final updatedList = quoteListBloc.state.lists[existingIndex]
        ..quotes = quotes;

      quoteListBloc.add(UpdateQuoteListQuotes(
          updatedQuotes: updatedList.quotes, quoteList: updatedList));
    } else {
      // Add new list if not already present
      quoteListBloc.add(AddQuoteList(quoteList: list));
    }

    return list;
  }

  /// Load a custom quote list from Hive and register in BLoC
  Future<QuoteList> loadCustomQuoteList(String name) async {
    final box = await Hive.openBox<StoredQuote>(name);
    final quotes = box.values.toList();

    final list = QuoteList(name: name, isPrebuilt: false, filename: '', quotes: quotes);

    final existingIndex = quoteListBloc.state.lists.indexWhere(
      (l) =>
          l.name == list.name && l.filename == list.filename && !l.isPrebuilt,
    );

    if (existingIndex != -1) {
      // Replace quotes of the existing QuoteList
      final updatedList = quoteListBloc.state.lists[existingIndex]
        ..quotes = quotes;

      quoteListBloc.add(UpdateQuoteListQuotes(
          updatedQuotes: updatedList.quotes, quoteList: updatedList));
    } else {
      // Add new list if not already present
      quoteListBloc.add(AddQuoteList(quoteList: list));
    }

    return list;
  }

  /// Create empty custom list (Hive + BLoC)
  Future<void> createCustomQuoteList(QuoteList quoteList) async {
    await Hive.openBox<StoredQuote>(quoteList.name);
    quoteListBloc.add(AddQuoteList(quoteList: quoteList));
  }
  // Future<void> createCustomQuoteList(String name) async {
  //   await Hive.openBox<StoredQuote>(name);
  //   quoteListBloc.add(AddQuoteList(name: name, filename: '', isPrebuilt: false));
  // }

  /// Add a quote to a Hive-stored custom list
  Future<void> addQuoteToCustomList(
      QuoteList quoteList, StoredQuote quote) async {
    final box = await Hive.openBox<StoredQuote>(quoteList.name);
    await box.add(quote);

    final updatedQuotes = box.values.toList();
    quoteListBloc.add(UpdateQuoteListQuotes(
        quoteList: quoteList, updatedQuotes: updatedQuotes));
  }
  // Future<void> addQuoteToCustomList(String listName, StoredQuote quote) async {
  //   final box = await Hive.openBox<StoredQuote>(listName);
  //   await box.add(quote);

  //   final updatedQuotes = box.values.toList();
  //   quoteListBloc.add(
  //       UpdateQuoteListQuotes(name: listName, updatedQuotes: updatedQuotes));
  // }

  /// Remove a quote from a custom Hive list
  Future<void> removeQuoteFromCustomList(
      QuoteList quoteList, StoredQuote quote) async {
    final box = await Hive.openBox<StoredQuote>(quoteList.name);
    final key = box.keys.firstWhere(
      (k) {
        final q = box.get(k);
        return q?.quoteText == quote.quoteText &&
            q?.authorText == quote.authorText;
      },
      orElse: () => null,
    );
    if (key != null) {
      await box.delete(key);
    }

    final updatedQuotes = box.values.toList();
    quoteListBloc.add(UpdateQuoteListQuotes(
        quoteList: quoteList, updatedQuotes: updatedQuotes));
  }
  // Future<void> removeQuoteFromCustomList(
  //     String listName, StoredQuote quote) async {
  //   final box = await Hive.openBox<StoredQuote>(listName);
  //   final key = box.keys.firstWhere(
  //     (k) {
  //       final q = box.get(k);
  //       return q?.quoteText == quote.quoteText &&
  //           q?.authorText == quote.authorText;
  //     },
  //     orElse: () => null,
  //   );
  //   if (key != null) {
  //     await box.delete(key);
  //   }

  //   final updatedQuotes = box.values.toList();
  //   quoteListBloc.add(
  //       UpdateQuoteListQuotes(name: listName, updatedQuotes: updatedQuotes));
  // }

  /// Delete a custom quote list completely
  Future<void> deleteCustomQuoteList(QuoteList quoteList) async {
    if (Hive.isBoxOpen(quoteList.name)) {
      await Hive.box<StoredQuote>(quoteList.name).deleteFromDisk();
    } else {
      await Hive.deleteBoxFromDisk(quoteList.name);
    }

    quoteListBloc.add(DeleteQuoteList(quoteList: quoteList));
  }
  // Future<void> deleteCustomQuoteList(String name) async {
  //   if (Hive.isBoxOpen(name)) {
  //     await Hive.box<StoredQuote>(name).deleteFromDisk();
  //   } else {
  //     await Hive.deleteBoxFromDisk(name);
  //   }

  //   quoteListBloc.add(DeleteQuoteList(name: name, quoteList: null));
  // }
}
