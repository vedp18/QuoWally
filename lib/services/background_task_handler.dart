import 'package:hive/hive.dart';
import 'package:quowally/models/author_style.dart';
import 'package:quowally/ui/widgets/set_wallpaper.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter/widgets.dart'; // for platformDispatcher
import '../models/quote.dart';
import '../blocs/quote_bloc/quote_bloc.dart';
import '../blocs/author_bloc/author_bloc.dart';
import '../blocs/wallpaper_bloc/wallpaper_bloc.dart';
import '../blocs/auto_change_quote_bloc/auto_change_quote_bloc.dart';

import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<void> logToFile(String message) async {
  print("look i m here");
  try {
    final path = '/data/user/0/com.vpx.quowally/app_flutter/log.txt';
    final file = File(path);
    final timestamp = DateTime.now().toIso8601String();

    await file.writeAsString("[$timestamp] $message\n", mode: FileMode.append);
  } catch (e) {
    // optional fallback
    print("Logging failed: $e");
  }
}

@pragma('vm:entry-point')
Future<void> callbackDispatcher() async {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().executeTask((task, inputData) async {
    // lo ("hey i m here");
    await logToFile("hey i m here");

    final hydratedBox = await Hive.openBox('hydrated_bloc');

    final rawAuto = hydratedBox.get('AutoChangeQuoteBloc');
    if (rawAuto == null) return Future.value(false);

    final autoState =
        AutoChangeQuoteState.fromMap(Map<String, dynamic>.from(rawAuto));
    final quoteList = autoState.selectedQuoteList;

    await logToFile("QuoteList: ${quoteList.name}");

    if (quoteList.quotes.isEmpty) return Future.value(false);

    int index = quoteList.quoteIndex;
    if (index >= quoteList.quotes.length) index = 0;
    await logToFile("index: $index");
    final storedQuote = quoteList.quotes[index];
    await logToFile("current quote: ${storedQuote.quoteText}");
    quoteList.quoteIndex = (index + 1) % quoteList.quotes.length;

    // Update QuoteBloc state
    final rawQuote = hydratedBox.get('QuoteBloc');
    final quoteBlocState =
        QuoteState.fromMap(Map<String, dynamic>.from(rawQuote));
    final updatedQuote = Quote(
      quote: storedQuote.quoteText,
      author: storedQuote.authorText,
      quoteStyle: quoteBlocState.updatedQuote.quoteStyle,
      authorStyle: AuthorStyle(),
    );
    final newQuoteState = quoteBlocState.copyWith(updatedQuote: updatedQuote);
    hydratedBox.put('QuoteBloc', newQuoteState.toJson());

    // Update AuthorBloc state
    final rawAuthor = hydratedBox.get('AuthorBloc');
    final authorBlocState =
        AuthorState.fromMap(Map<String, dynamic>.from(rawAuthor));
    final updatedAuthor = authorBlocState.updatedAuthorStyle;
    updatedQuote.authorStyle = updatedAuthor;
    hydratedBox.put('AuthorBloc', authorBlocState.toJson());

    // Update WallpaperBloc state
    final rawWallpaper = hydratedBox.get('WallpaperBloc');
    final wallpaperBlocState =
        WallpaperState.fromMap(Map<String, dynamic>.from(rawWallpaper));
    final newWallpaper =
        wallpaperBlocState.wallpaper.copyWith(quote: updatedQuote);
    final newWallpaperState =
        wallpaperBlocState.copyWith(wallpaper: newWallpaper);
    hydratedBox.put('WallpaperBloc', newWallpaperState.toJson());

    // Set wallpaper
    final view = WidgetsBinding.instance.platformDispatcher.views.first;
    final screenSize = view.physicalSize / view.devicePixelRatio;

    await SetWallPaper.setWallpaper(
      wallpaper: newWallpaper,
      which: autoState.screen,
      wd: screenSize.width,
      ht: screenSize.height,
    );

    return Future.value(true);
  });
}




// import 'dart:io';
// import 'package:flutter/widgets.dart';
// import 'package:hive/hive.dart';
// import 'package:quowally/models/author_style.dart';
// import 'package:quowally/ui/widgets/set_wallpaper.dart';

// import '../models/quote.dart';
// import '../blocs/quote_bloc/quote_bloc.dart';
// import '../blocs/author_bloc/author_bloc.dart';
// import '../blocs/wallpaper_bloc/wallpaper_bloc.dart';
// import '../blocs/auto_change_quote_bloc/auto_change_quote_bloc.dart';

// /// Log helper (same as before)
// Future<void> logToFile(String message) async {
//   try {
//     final file = File('/data/data/com.vpx.quowally/app_flutter/log.txt');
//     if (!(await file.exists())) {
//       await file.create(recursive: true);
//     }
//     final timestamp = DateTime.now().toIso8601String();
//     await file.writeAsString("[$timestamp] $message\n", mode: FileMode.append);
//   } catch (_) {}
// }

// @pragma('vm:entry-point')
// Future<void> autoChangeWallpaperTask() async {
//   print("hyyy");
//   WidgetsFlutterBinding.ensureInitialized();

//   await logToFile("🔁 AlarmManager task started");

//   final hydratedBox = await Hive.openBox('hydrated_bloc');

//   final rawAuto = hydratedBox.get('AutoChangeQuoteBloc');
//   if (rawAuto == null) return;

//   final autoState =
//       AutoChangeQuoteState.fromMap(Map<String, dynamic>.from(rawAuto));
//   final quoteList = autoState.selectedQuoteList;

//   await logToFile("QuoteList: ${quoteList.name}");

//   if (quoteList.quotes.isEmpty) return;

//   int index = quoteList.quoteIndex;
//   if (index >= quoteList.quotes.length) index = 0;
//   final storedQuote = quoteList.quotes[index];
//   quoteList.quoteIndex = (index + 1) % quoteList.quotes.length;

//   await logToFile("QuoteIndex: $index");
//   await logToFile("QuoteText: ${storedQuote.quoteText}");

//   // Update QuoteBloc state
//   final rawQuote = hydratedBox.get('QuoteBloc');
//   final quoteBlocState =
//       QuoteState.fromMap(Map<String, dynamic>.from(rawQuote));
//   final updatedQuote = Quote(
//     quote: storedQuote.quoteText,
//     author: storedQuote.authorText,
//     quoteStyle: quoteBlocState.updatedQuote.quoteStyle,
//     authorStyle: AuthorStyle(),
//   );
//   final newQuoteState = quoteBlocState.copyWith(updatedQuote: updatedQuote);
//   hydratedBox.put('QuoteBloc', newQuoteState.toJson());

//   // Update AuthorBloc state
//   final rawAuthor = hydratedBox.get('AuthorBloc');
//   final authorBlocState =
//       AuthorState.fromMap(Map<String, dynamic>.from(rawAuthor));
//   final updatedAuthor = authorBlocState.updatedAuthorStyle;
//   updatedQuote.authorStyle = updatedAuthor;
//   hydratedBox.put('AuthorBloc', authorBlocState.toJson());

//   // Update WallpaperBloc state
//   final rawWallpaper = hydratedBox.get('WallpaperBloc');
//   final wallpaperBlocState =
//       WallpaperState.fromMap(Map<String, dynamic>.from(rawWallpaper));
//   final newWallpaper =
//       wallpaperBlocState.wallpaper.copyWith(quote: updatedQuote);
//   final newWallpaperState =
//       wallpaperBlocState.copyWith(wallpaper: newWallpaper);
//   hydratedBox.put('WallpaperBloc', newWallpaperState.toJson());

//   // Set wallpaper
//   final view = WidgetsBinding.instance.platformDispatcher.views.first;
//   final screenSize = view.physicalSize / view.devicePixelRatio;

//   await SetWallPaper.setWallpaper(
//     wallpaper: newWallpaper,
//     which: autoState.screen,
//     wd: screenSize.width,
//     ht: screenSize.height,
//   );

//   await logToFile("✅ Wallpaper changed to: ${storedQuote.quoteText}");
// }
