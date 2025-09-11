import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hive/hive.dart';
// import 'package:quowally/models/quote.dart';
import 'package:quowally/models/quote_list.dart';
import 'package:quowally/models/stored_quote.dart';
import 'package:quowally/blocs/quote_list_bloc/quote_list_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:quowally/secrets.dart';
// import 'package:quowally/';

class QuoteListProvider {
  final QuoteListBloc quoteListBloc;

  QuoteListProvider(this.quoteListBloc);


  Future<QuoteList> loadGistQuoteList({
    // required String gistId,
    required String filename,
    required String name,
  }) async {

    final url = Uri.parse(
        "https://api.github.com/gists/5b5d74259675bd14bb2b65692697d410");

    final response = await http.get(
      url,
      headers: {
        "Bearer": GITHUB_PAT,
        "Accept": "application/vnd.github.v3+json",
      },
    );

    if (response.statusCode != 200) {
      // throw Exception("Failed to fetch gist: ${response.body}");
      print("Failed to fetch gist: ${response.body}");
    }

    final data = json.decode(response.body);
    final fileContent = data['files'][filename]?['content'];

    if (fileContent == null) {
      // throw Exception("File $filename not found in gist");
      print("File $filename not found in gist");
    }

    final List<dynamic> jsonList = json.decode(fileContent);
    final quotes = jsonList.map((e) => StoredQuote.fromMap(e)).toList();

    final list = QuoteList(
      name: p.basenameWithoutExtension(name),
      isPrebuilt: true, // Treat gist lists same as prebuilt?
      filename: filename,
      quotes: quotes,
    );

    // Update BLoC state
    final existingIndex = quoteListBloc.state.lists.indexWhere(
      (l) => l.name == list.name && l.filename == list.filename,
    );

    if (existingIndex != -1) {
      final updatedList = quoteListBloc.state.lists[existingIndex]
        ..quotes = quotes;
      
      quoteListBloc.add(UpdateQuoteListQuotes(
        updatedQuotes: updatedList.quotes,
        quoteList: updatedList,
      ));

      print("${updatedList.name} quoteList exist so updated");
    } else {
      quoteListBloc.add(AddQuoteList(quoteList: list));
      print("${list.name} quoteList not existed so added");
    }

    

    return list;
  }

  Future<List<String>> getQuoteListNamesfromGist() async {
    final url = Uri.parse(
        "https://api.github.com/gists/5b5d74259675bd14bb2b65692697d410",);
    final response = await http.get(
      url,
      headers: {
        "Bearer":GITHUB_PAT,
        "Accept": "application/vnd.github.v3+json",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final files = data["files"] as Map<String, dynamic>;
      print(files.keys.toList());
      return files.keys.toList(); // Extract filenames
    } else {
      throw Exception("Failed to load gist: ${response.statusCode}");
    }
  }






  /// Load prebuilt list from assets and register in BLoC
  // Future<QuoteList> loadPrebuiltQuoteList({
  //   required String name,
  //   required String filename,
  // }) async {
  //   final String jsonStr = await rootBundle.loadString(filename);
  //   // print(jsonStr.length);
  //   final List<dynamic> jsonList = json.decode(jsonStr);
  //   // print(jsonList.first.toString());

  //   final quotes = jsonList.map((e) => StoredQuote.fromMap(e)).toList();
  //   // print("quotesLength: ${quotes.length}");
  //   // print(quotes.first.quoteText);

  //   final list = QuoteList(name: name, isPrebuilt: true, filename: filename, quotes: quotes);

  //   final existingIndex = quoteListBloc.state.lists.indexWhere(
  //     (l) => l.name == list.name && l.filename == list.filename && l.isPrebuilt,
  //   );

  //   if (existingIndex != -1) {
  //     // Replace quotes of the existing QuoteList
  //     final updatedList = quoteListBloc.state.lists[existingIndex]
  //       ..quotes = quotes;

  //     quoteListBloc.add(UpdateQuoteListQuotes(
  //         updatedQuotes: updatedList.quotes, quoteList: updatedList));
  //   } else {
  //     // Add new list if not already present
  //     quoteListBloc.add(AddQuoteList(quoteList: list));
  //   }

  //   return list;
  // }

  /// Load all custom quote lists from Hive and register them in BLoC
  Future<void> loadCustomQuoteLists() async {
    final box = await Hive.openBox<QuoteList>('quoteLists');

    for (final list in box.values) {
      // Only load non-prebuilt lists
      if (!list.isPrebuilt) {
        final existingIndex = quoteListBloc.state.lists.indexWhere(
          (l) => l.name == list.name && !l.isPrebuilt,
        );

        if (existingIndex != -1) {
          // Update existing list with latest Hive data
          final updatedList = list;
          quoteListBloc.add(UpdateQuoteListQuotes(
            updatedQuotes: updatedList.quotes,
            quoteList: updatedList,
          ));
        } else {
          // Add as new custom list
          quoteListBloc.add(AddQuoteList(quoteList: list));
        }
      }
    }
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
