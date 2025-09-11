// import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
// import 'package:quowally/models/quote.dart';
import 'package:quowally/models/quote_list.dart';
import 'package:quowally/models/stored_quote.dart';

part 'quote_list_event.dart';
part 'quote_list_state.dart';

class QuoteListBloc extends Bloc<QuoteListEvent, QuoteListState> {
  QuoteListBloc() : super(QuoteListState.initial()) {
    on<AddQuoteList>(_onAddQuoteList);
    on<DeleteQuoteList>(_onDeleteQuoteList);
    on<UpdateQuoteListQuotes>(_onUpdateQuoteListQuotes);
  }

  void _onAddQuoteList(AddQuoteList event, Emitter<QuoteListState> emit) async {
    final updatedLists = List<QuoteList>.from(state.lists)
      ..add(event.quoteList);

    // Open single box that stores all QuoteLists
    final box = await Hive.openBox<QuoteList>('quoteLists');

    // Save the new list
    await box.put(event.quoteList.name, event.quoteList);

    emit(state.copyWith(lists: updatedLists));
  }

  void _onDeleteQuoteList(
      DeleteQuoteList event, Emitter<QuoteListState> emit) async {
    final updatedLists =
        state.lists.where((list) => list != event.quoteList).toList();

    // Remove from Hive (using name as key)
    final box = await Hive.openBox<QuoteList>('quoteLists');
    await box.delete(event.quoteList.name);

    emit(state.copyWith(lists: updatedLists));
  }

  void _onUpdateQuoteListQuotes(
      UpdateQuoteListQuotes event, Emitter<QuoteListState> emit) async {
    final updated = state.lists.map((list) {
      if (list.name == event.quoteList.name) {
        return QuoteList(
          name: list.name,
          isPrebuilt: list.isPrebuilt,
          filename: list.filename,
          quotes: event.updatedQuotes,
          quoteIndex: list.quoteIndex,
        );
      }
      return list;
    }).toList();

    emit(state.copyWith(lists: updated));

    // Update Hive
    final box = await Hive.openBox<QuoteList>('quoteLists');
    final updatedList =
        updated.firstWhere((l) => l.name == event.quoteList.name);
    await box.put(updatedList.name, updatedList);
  }

  //? only for hydrated bloc

  // @override
  // QuoteListState? fromJson(Map<String, dynamic> json) {
  //   return QuoteListState.fromJson(json);
  // }

  // @override
  // Map<String, dynamic>? toJson(QuoteListState state) {
  //   return state.toJson();
  // }
}
