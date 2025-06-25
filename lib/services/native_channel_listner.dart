import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quowally/blocs/quote_bloc/quote_bloc.dart';
import 'package:quowally/utils/custom_logger.dart';

class NativeChannelListener {
  static const MethodChannel _wallpaperChannel =
      MethodChannel('wallpaper_channel');

  /// This should be called once in the app with a valid context
  static void register(QuoteBloc quoteBloc) {
    _wallpaperChannel.setMethodCallHandler((call) async {
      if (call.method == 'onWallpaperChanged') {
        await CustomLogger.logToFile("call from kotlin");
        // print('📲 Wallpaper updated from native!');
        try {
          final box = await Hive.openBox('hydrated_box');
          await box.close(); // ensures flush
          final reloadedBox = await Hive.openBox('hydrated_box');
          final raw = reloadedBox.get('QuoteBloc');

          final storedState = QuoteState.fromMap(
            (raw as Map).map((key, value) => MapEntry(key.toString(), value)),
          );
          await CustomLogger.logToFile(
              "Quote from hydratedstorage-quotebloc:${storedState.updatedQuote.quote}");

          quoteBloc.add(QuoteChangedEvent(
            newAuthorText: storedState.updatedQuote.author,
            newQuoteText: storedState.updatedQuote.quote,
          ));
          await CustomLogger.logToFile("quote bloc updated in ui");
        } catch (e) {
          debugPrint("❌ Sync error: $e");
        }

        /// Safely dispatch event to QuoteBloc
      }
    });
  }
}
