import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:quowally/models/quote_list.dart';

part 'quote_list_event.dart';
part 'quote_list_state.dart';


class QuoteListBloc extends HydratedBloc<QuoteListEvent, QuoteListState> {
  QuoteListBloc() : super(QuoteListState.initial()) {
    
    on<AddQuoteList>((event, emit) {
      final alreadyExists = state.lists.any((l) => l.name == event.name);
      if (!alreadyExists) {
        emit(state.copyWith(
          lists: [...state.lists, QuoteList(name: event.name, filename: event.filename)],
        ));
      }
    });

    on<DeleteQuoteList>((event, emit) {
      final updated = state.lists.where((l) {
        return l.name != event.name || l.isPrebuilt;
      }).toList();
      emit(state.copyWith(lists: updated));
    });
  }

  @override
  QuoteListState? fromJson(Map<String, dynamic> json) {
    return QuoteListState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(QuoteListState state) {
    return state.toJson();
  }
}
