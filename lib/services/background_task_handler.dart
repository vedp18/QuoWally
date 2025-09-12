import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quowally/models/author_style.dart';
import 'package:quowally/ui/widgets/set_wallpaper.dart';
import 'package:quowally/utils/custom_logger.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter/widgets.dart'; // for platformDispatcher
import '../models/quote.dart';
import '../blocs/quote_bloc/quote_bloc.dart';
import '../blocs/author_bloc/author_bloc.dart';
import '../blocs/wallpaper_bloc/wallpaper_bloc.dart';
import '../blocs/auto_change_quote_bloc/auto_change_quote_bloc.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().executeTask((task, inputData) async {
    // if (task != 'auto_change_quowally') {
    //   await CustomLogger.logToFile("wrong task");
    //   return Future.value(false);
    // } else {
    try {
      await CustomLogger.logToFile(
          "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
      await CustomLogger.logToFile("Executing Task: $task");

      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      final hydratedBox = await Hive.openBox('hydrated_box');

      print("keys: ${hydratedBox.keys.length}");
      await CustomLogger.logToFile(hydratedBox.keys.toList().toString());

      final rawAuto = hydratedBox.get('AutoChangeQuoteBloc');
      if (rawAuto == null) {
        await CustomLogger.logToFile(
            "failed at <inal rawAuto = hydratedBox.get('AutoChangeQuoteBloc');> ");
        return Future.value(false);
      }

      // await CustomLogger.logToFile(rawAuto.runtimeType.toString());

      // final autoState = AutoChangeQuoteState.fromMap(rawAuto);
      final autoState = AutoChangeQuoteState.fromMap(
        (rawAuto as Map).map(
          (key, value) => MapEntry(key.toString(), value),
        ),
      );
      final quoteList = autoState.selectedQuoteList;

      await CustomLogger.logToFile("QuoteList: ${quoteList.name}");

      if (quoteList.quotes.isEmpty) {
        await CustomLogger.logToFile("failed at <quoteList.quotes isEmpty");
        return Future.value(false);
      }

      int index = inputData!['quoteIndex'];
      // int index = quoteList.quoteIndex;
      if (index >= quoteList.quotes.length) index = 0;

      await CustomLogger.logToFile("index: $index");

      final storedQuote = quoteList.quotes[index];
      await CustomLogger.logToFile("next quote: ${storedQuote.quoteText}");

      // quoteList.quoteIndex = (index + 1) % quoteList.quotes.length;

      // final newAutoState = autoState.copyWith(selectedQuoteList: quoteList);
      // hydratedBox.put('AutoChangeQuoteBloc', newAutoState.toMap());

      // Update QuoteBloc state
      final rawQuote = hydratedBox.get('QuoteBloc');
      if (rawQuote == null) {
        await CustomLogger.logToFile(
            "failed at < final rawQuote = hydratedBox.get('QuoteBloc');> ");
        return Future.value(false);
      }

      final quoteBlocState = QuoteState.fromMap(
        (rawQuote as Map).map(
          (key, value) => MapEntry(key.toString(), value),
        ),
      );

      await CustomLogger.logToFile(
          "QuoteBloc:- currentQuote  ${quoteBlocState.updatedQuote.quote}");

      final updatedQuote = Quote(
        quote: storedQuote.quoteText,
        author: storedQuote.authorText,
        quoteStyle: quoteBlocState.updatedQuote.quoteStyle,
        authorStyle: AuthorStyle(),
      );
      final newQuoteState = quoteBlocState.copyWith(updatedQuote: updatedQuote);
      hydratedBox.put('QuoteBloc', newQuoteState.toMap());

      await CustomLogger.logToFile("QuoteBloc is updated");

      //? this was there for testing quotebloc
      // final rawQuote1 = hydratedBox.get('QuoteBloc');
      // if (rawQuote1 == null) {
      //   await CustomLogger.logToFile(
      //       "failed at < final rawQuote1 = hydratedBox.get('QuoteBloc');> ");
      //   return Future.value(false);
      // }

      // final quoteBlocState1 = QuoteState.fromMap(
      //   (rawQuote1 as Map).map(
      //     (key, value) => MapEntry(key.toString(), value),
      //   ),
      // );

      // await CustomLogger.logToFile(
      //     "QuoteBloc:- currentQuote  ${quoteBlocState1.updatedQuote.quote}");

      // Update AuthorBloc state
      final rawAuthor = hydratedBox.get('AuthorBloc');
      if (rawAuthor == null) {
        await CustomLogger.logToFile(
            "failed at <final rawAuthor = hydratedBox.get('AuthorBloc');> ");
        return Future.value(false);
      }
      final authorBlocState = AuthorState.fromMap(
        (rawAuthor as Map).map(
          (key, value) => MapEntry(key.toString(), value),
        ),
      );

      await CustomLogger.logToFile(
          "authorBlocState : I got to AuthorBlocState");

      final updatedAuthor = authorBlocState.updatedAuthorStyle;
      updatedQuote.authorStyle = updatedAuthor;
      hydratedBox.put('AuthorBloc', authorBlocState.toMap());

      await CustomLogger.logToFile("AuthorBloc is updated");

      // Update WallpaperBloc state
      final rawWallpaper = hydratedBox.get('WallpaperBloc');
      if (rawWallpaper == null) {
        await CustomLogger.logToFile(
            "failed at <final rawWallpaper = hydratedBox.get('WallpaperBloc');> ");
        return Future.value(false);
      }
      final wallpaperBlocState = WallpaperState.fromMap(
        (rawWallpaper as Map).map(
          (key, value) => MapEntry(key.toString(), value),
        ),
      );

      await CustomLogger.logToFile(
          "wallpaperBlocState : I got to WallpaperBlocState");

      final newWallpaper =
          wallpaperBlocState.wallpaper.copyWith(quote: updatedQuote);
      final newWallpaperState =
          wallpaperBlocState.copyWith(wallpaper: newWallpaper);
      hydratedBox.put('WallpaperBloc', newWallpaperState.toMap());

      await CustomLogger.logToFile("WallpaperBloc is updated");

      // Set wallpaper

      await SetWallPaper.setWallpaper(
        wallpaper: newWallpaper,
        which: autoState.screen,
        ht: inputData!['physicalHt'],
        wd: inputData['physicalWd'],
      );

      await CustomLogger.logToFile(
          "Wallpaper is Set: ${newWallpaper.toString()}");

      await CustomLogger.logToFile(
          "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");

      await CustomLogger.logToFile("New task scheduling......");
      await Workmanager().registerOneOffTask(
        'auto_change_quowally',
        'auto_change_quowally_[${DateTime.now().toLocal()}]',
        existingWorkPolicy: ExistingWorkPolicy.replace,
        inputData: {
          "quoteIndex": (index + 1),
          "intervalInMinutes": inputData['intervalInMinutes'],
          "physicalHt": inputData['physicalHt'],
          "physicalWd": inputData['physicalWd'],
        },
        initialDelay: Duration(minutes: inputData['intervalInMinutes']),
      );

      return Future.value(true);
    } catch (e) {
      await CustomLogger.logToFile(e.toString());
      return Future.value(false);
    }
  });
}
