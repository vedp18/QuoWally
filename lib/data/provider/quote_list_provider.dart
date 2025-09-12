import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:quowally/models/quote_list.dart';
import 'package:quowally/models/stored_quote.dart';
import 'package:quowally/blocs/quote_list_bloc/quote_list_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:quowally/secrets.dart';
import 'package:quowally/utils/custom_logger.dart';

class QuoteListProvider {
  final QuoteListBloc quoteListBloc;

  QuoteListProvider(this.quoteListBloc);

  Future<void> loadGistQuoteList({
    required String filename,
    required String name,
  }) async {
    final url = Uri.parse(
      "https://api.github.com/gists/5b5d74259675bd14bb2b65692697d410",
    );

    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $GITHUB_PAT",
        "Accept": "application/vnd.github.v3+json",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch gist: ${response.body}");
    }

    final data = json.decode(response.body);
    final fileContent = data['files'][filename]?['content'];

    if (fileContent == null) {
      throw Exception("File $filename not found in gist");
    }

    final List<dynamic> jsonList = json.decode(fileContent);
    final quotes = jsonList.map((e) => StoredQuote.fromMap(e)).toList();

    final list = QuoteList(
      name: p.basenameWithoutExtension(filename), // safer
      isPrebuilt: true,
      filename: filename,
      quotes: quotes,
    );

    // Checking that quoteList already exists in state
    final existingIndex = quoteListBloc.state.lists.indexWhere(
      (l) => l.name == list.name && l.filename == list.filename,
    );

    if (existingIndex != -1) {
      final oldList = quoteListBloc.state.lists[existingIndex];

      // Map old quotes by hashCode
      final oldQuotesMap = {for (var q in oldList.quotes) q.hashCode: q};

      // Map new (gist) quotes by hashCode
      final newQuotesMap = {for (var q in quotes) q.hashCode: q};

      // 1. Keep only quotes that are still present in gist
      final keptQuotes = oldList.quotes
          .where((q) => newQuotesMap.containsKey(q.hashCode))
          .toList();

      // 2. Add new quotes that weren’t in old list
      final newOnes = quotes
          .where((q) => !oldQuotesMap.containsKey(q.hashCode))
          .map((q) => q.copyWith(isFavourite: false))
          .toList();

      // 3. Merge both
      final mergedQuotes = [...keptQuotes, ...newOnes];

      final updatedList = oldList.copyWith(quotes: mergedQuotes);

      quoteListBloc.add(UpdateQuoteListQuotes(
        updatedQuotes: updatedList.quotes,
        quoteList: updatedList,
      ));

      CustomLogger.logToFile(
          "${updatedList.name} quoteList existed so updated in QuoteListBloc");
    } else {
      // Add
      quoteListBloc.add(AddQuoteList(quoteList: list));
      CustomLogger.logToFile(
          "${list.name} quoteList does not exist, so added to QuoteListBloc");
    }
  }

  Future<List<String>> getQuoteListNamesfromGist() async {
    final url = Uri.parse(
      "https://api.github.com/gists/5b5d74259675bd14bb2b65692697d410",
    );
    final response = await http.get(
      url,
      headers: {
        "Bearer": GITHUB_PAT,
        "Accept": "application/vnd.github.v3+json",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final files = data["files"] as Map<String, dynamic>;
      CustomLogger.logToFile(
          "QuoteLists in from Gist: ${files.keys.toList().toString()}");
      return files.keys.toList(); // Extract filenames
    } else {
      throw Exception(
          "Failed to load QuoteList names from gist: ${response.body}");
    }
  }

  /// Load all custom quote lists from Hive and register them in BLoC
//   Future<void> loadCustomQuoteLists() async {
//     final box = await Hive.openBox<QuoteList>('quoteLists');
//
//     for (final list in box.values) {
//       // Only load non-prebuilt lists
//       if (!list.isPrebuilt) {
//         final existingIndex = quoteListBloc.state.lists.indexWhere(
//           (l) => l.name == list.name && !l.isPrebuilt,
//         );
//
//         if (existingIndex != -1) {
//           // Update existing list with latest Hive data
//           final updatedList = list;
//           quoteListBloc.add(UpdateQuoteListQuotes(
//             updatedQuotes: updatedList.quotes,
//             quoteList: updatedList,
//           ));
//         } else {
//           // Add as new custom list
//           quoteListBloc.add(AddQuoteList(quoteList: list));
//         }
//       }
//     }
//   }
}
