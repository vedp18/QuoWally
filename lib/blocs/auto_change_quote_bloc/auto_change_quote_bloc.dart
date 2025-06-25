import 'package:flutter/widgets.dart';
import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:quowally/models/quote_list.dart';
import 'package:quowally/services/auto_change_scheduler_service.dart';

part 'auto_change_quote_event.dart';
part 'auto_change_quote_state.dart';

class AutoChangeQuoteBloc
    extends HydratedBloc<AutoChangeQuoteEvent, AutoChangeQuoteState> {
  AutoChangeQuoteBloc() : super(AutoChangeQuoteState.initial()) {
    on<ToggleAutoChange>((event, emit) {

      final newState = state.copyWith(isEnabled: event.enabled);
      emit(newState);
      
      if (!event.enabled) {
        AutoChangeSchedulerService.cancelAutoChangeTask();
        // AutoChangeSchedulerService.scheduleAutoChangeTask(
        //     newState.interval.inMinutes);
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
}
