import 'package:flutter/widgets.dart';
import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:quowally/models/quote_list.dart';
import 'package:quowally/services/auto_change_scheduler_service.dart';

part 'auto_change_quote_event.dart';
part 'auto_change_quote_state.dart';

class AutoChangeQuoteBloc
    extends HydratedBloc<AutoChangeQuoteEvent, AutoChangeQuoteState> {
  // Timer? _timer;

  AutoChangeQuoteBloc() : super(AutoChangeQuoteState.initial()) {
    on<ToggleAutoChange>((event, emit) async {
      // 1
      final newState = state.copyWith(isEnabled: event.isEnabled);
      emit(newState);

      // 2
      if (event.isEnabled) {
        // _scheduleAutoChangeTask(newState.intervalMinutes);
        // _startAutoChange(state, event.context);
        await AutoChangeSchedulerService.scheduleAutoChangeTask(
            newState.interval.inMinutes);
      } else {
        // _cancelAutoChangeTask();
        // _stopAutoChange();
        await AutoChangeSchedulerService.cancelAutoChangeTask();
      }
    });

    on<UpdateQuoteList>((event, emit) {
      emit(state.copyWith(selectedQuoteList: event.newQuoteList));
    });

    on<UpdateInterval>((event, emit) {
      emit(state.copyWith(interval: event.interval));
    });

    on<UpdateScreen>((event, emit) {
      emit(state.copyWith(screen: event.screen));
    });
  }

  @override
  AutoChangeQuoteState? fromJson(Map<String, dynamic> json) {
    try {
      return AutoChangeQuoteState.fromMap(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(AutoChangeQuoteState state) {
    try {
      return state.toMap();
    } catch (_) {
      return null;
    }
  }

  // void _startAutoChange(AutoChangeQuoteState state, BuildContext context) {
  //   // Cancel any existing timer
  //   _timer?.cancel();

  //   // Immediately run once, then every [intervalMinutes]
  //   _timer = Timer.periodic(
  //     Duration(minutes: state.interval.inMinutes),
  //     (_) async {

  //       // ▶️ 1. Tell QuoteBloc to advance to the next quote
  //       // Wait for the QuoteBloc to pick up the new quote
  //       final QuoteList selectedQuoteList =
  //           context.read<AutoChangeQuoteBloc>().state.selectedQuoteList;
  //       final int index = selectedQuoteList.getAndIncrementIndex();
  //       final quote = selectedQuoteList.quotes[index];

  //       // ▶️ 2. Grab the updated current quote from QuoteBloc
  //       context.read<QuoteBloc>().add(QuoteChangedEvent(
  //           newAuthorText: quote.authorText, newQuoteText: quote.quoteText));

  //       final Quote currentQuote = context.read<QuoteBloc>().state.updatedQuote;
  //       currentQuote.authorStyle =
  //           context.read<AuthorBloc>().state.updatedAuthorStyle;

  //       // await Future.delayed(Duration(milliseconds: 100));

  //       // ▶️ 3. Call your existing service to actually set the wallpaper
  //       // final platformDispatcher = WidgetsBinding.instance.platformDispatcher;
  //       // final double wd = platformDispatcher.views.first.physicalSize.width;
  //       // final double ht = platformDispatcher.views.first.physicalSize.height;

  //       final double dpWd = MediaQuery.of(context).size.width;
  //       final double dpHt = MediaQuery.of(context).size.height;

  //       final double physicalWd = dpWd * MediaQuery.devicePixelRatioOf(context);
  //       final double physicalHt = dpHt * MediaQuery.devicePixelRatioOf(context);

  //       final currentWallpaper = BlocProvider.of<WallpaperBloc>(context).state.wallpaper;
  //       currentWallpaper.quote = currentQuote;

  //       SetWallPaper.setWallpaper(
  //           wd: physicalWd, ht: physicalHt, which: state.screen, wallpaper: currentWallpaper);
  //     },
  //   );

  //   // Optionally run immediately on toggle‑on:
  //   _timer!.tick;
  // }

  // void _stopAutoChange() {
  //   _timer?.cancel();
  //   _timer = null;
  // }
}
