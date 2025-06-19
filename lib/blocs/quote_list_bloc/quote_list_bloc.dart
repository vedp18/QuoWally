import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:quowally/models/quote.dart';
import 'package:quowally/models/quote_list.dart';
import 'package:quowally/models/stored_quote.dart';

part 'quote_list_event.dart';
part 'quote_list_state.dart';

class QuoteListBloc extends HydratedBloc<QuoteListEvent, QuoteListState> {
  QuoteListBloc() : super(QuoteListState.initial()) {
    on<AddQuoteList>(_onAddQuoteList);
    on<DeleteQuoteList>(_onDeleteQuoteList);
    on<UpdateQuoteListQuotes>(_onUpdateQuoteListQuotes);

    // on<AddQuoteList>((event, emit) {
    //   final alreadyExists = state.lists.any((l) => l.name == event.name);
    //   if (!alreadyExists) {
    //     emit(state.copyWith(
    //       lists: [...state.lists, QuoteList(name: event.name, filename: event.filename)],
    //     ));
    //   }
    // });

    // on<DeleteQuoteList>((event, emit) {
    //   final updated = state.lists.where((l) {
    //     return l.name != event.name || l.isPrebuilt;
    //   }).toList();
    //   emit(state.copyWith(lists: updated));
    // });

    // on<UpdateQuoteListQuotes>((event, emit) {
    //   final updated = state.lists.map((list) {
    //     if (list.name == event.name) {
    //       return QuoteList(
    //         name: list.name,
    //         isPrebuilt: list.isPrebuilt,
    //         filename: list.filename,
    //       )..quotes = event.updatedQuotes;
    //     }
    //     return list;
    //   }).toList();

    //   emit(state.copyWith(lists: updated));
    // });
  }

  void _onAddQuoteList(AddQuoteList event, Emitter<QuoteListState> emit) {
    final updatedLists = List<QuoteList>.from(state.lists)
      ..add(event.quoteList);
    emit(state.copyWith(lists: updatedLists));
  }

  void _onDeleteQuoteList(DeleteQuoteList event, Emitter<QuoteListState> emit) {
    final updatedLists =
        state.lists.where((list) => list != event.quoteList).toList();
    emit(state.copyWith(lists: updatedLists));
  }

  void _onUpdateQuoteListQuotes(
      UpdateQuoteListQuotes event, Emitter<QuoteListState> emit) {
    final updated = state.lists.map((list) {
      if (list.name == event.quoteList.name) {
        return QuoteList(
          name: list.name,
          isPrebuilt: list.isPrebuilt,
          filename: list.filename,
        )..quotes = event.updatedQuotes;
      }
      return list;
    }).toList();

    emit(state.copyWith(lists: updated));

    // final updatedLists = state.lists.map((list) {
    //   if (list == event.quoteList) {
    //     return list.copyWith(quotes: event.updatedQuotes);
    //   } else {
    //     return list;
    //   }
    // }).toList();
    // emit(state.copyWith(lists: updatedLists));
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
