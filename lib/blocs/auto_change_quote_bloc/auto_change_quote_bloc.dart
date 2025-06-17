import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'auto_change_quote_event.dart';
part 'auto_change_quote_state.dart';

class AutoChangeQuoteBloc extends HydratedBloc<AutoChangeQuoteEvent, AutoChangeQuoteState> {

  AutoChangeQuoteBloc() : super(AutoChangeQuoteState.initial()) {
    
    on<ToggleAutoChange>((event, emit) {
      emit(state.copyWith(isEnabled: event.enabled));
    });

    on<UpdateQuoteList>((event, emit) {
      emit(state.copyWith(selectedQuoteList: event.listId));
    });

    on<UpdateInterval>((event, emit) {
      emit(state.copyWith(interval: event.interval));
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
