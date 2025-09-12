import 'package:hydrated_bloc/hydrated_bloc.dart';
// import 'package:bloc/bloc.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:quowally/models/quote.dart';
import 'package:quowally/models/quote_list.dart';
import 'package:quowally/models/stored_quote.dart';
import 'package:quowally/utils/custom_logger.dart';

import '../../data/provider/quote_list_provider.dart';

part 'quote_list_event.dart';
part 'quote_list_state.dart';

class QuoteListBloc extends HydratedBloc<QuoteListEvent, QuoteListState> {
  QuoteListBloc() : super(QuoteListState.initial()) {
    on<SyncQuoteListsEvent>(_onSyncQuoteListsEvent);
    on<AddQuoteList>(_onAddQuoteList);
    on<DeleteQuoteList>(_onDeleteQuoteList);
    on<UpdateQuoteListQuotes>(_onUpdateQuoteListQuotes);
    on<ToggleFavouriteQuoteEvent>(_onToggleFavouriteQuote);
  }

  void _onToggleFavouriteQuote(
    ToggleFavouriteQuoteEvent event,
    Emitter<QuoteListState> emit,
  ) {
    final updatedLists = state.lists.map((list) {
      if (list.name == event.quoteList.name) {
        final updatedQuotes = list.quotes.map((quote) {
          if (quote.quoteText == event.quote.quoteText) {
            return quote.copyWith(isFavourite: !quote.isFavourite);
          }
          return quote;
        }).toList();
        return list.copyWith(quotes: updatedQuotes);
      }
      return list;
    }).toList();
    emit(state.copyWith(lists: updatedLists));
  }

  // SyncQuoteListEvent handler
  Future<void> _onSyncQuoteListsEvent(
      SyncQuoteListsEvent event, Emitter<QuoteListState> emit) async {
    emit(state.copyWith(quoteListStatus: QuoteListStatus.loading));
    try {
      // Getting QuoteListProvider
      final provider = QuoteListProvider(this); // or inject properly
      // Fetching QuoteListNames from Gist
      final prebuiltListsNames = await provider.getQuoteListNamesfromGist();

      // Fetching QuoteLists from gists
      for (final prebuilt in prebuiltListsNames) {
        await provider.loadGistQuoteList(filename: prebuilt, name: prebuilt);
      }

      emit(state.copyWith(quoteListStatus: QuoteListStatus.success));
    } catch (e) {
      CustomLogger.logToFile(
          "Exception occurred while loading QuoteList from gist: $e");
      emit(state.copyWith(quoteListStatus: QuoteListStatus.failure));
    } finally {
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(quoteListStatus: QuoteListStatus.idle));
    }
  }

  void _onAddQuoteList(AddQuoteList event, Emitter<QuoteListState> emit) async {
    final updatedLists = List<QuoteList>.from(state.lists)
      ..add(event.quoteList);

    // Only save new lists
    // final box = await Hive.openBox<QuoteList>('quoteLists');
    // if (!box.containsKey(event.quoteList.name)) {
    //   await box.put(event.quoteList.name, event.quoteList);
    // }

    emit(state.copyWith(lists: updatedLists));
  }

  void _onDeleteQuoteList(
      DeleteQuoteList event, Emitter<QuoteListState> emit) async {
    final updatedLists =
        state.lists.where((list) => list != event.quoteList).toList();

    // Remove from Hive (using name as key)
    // final box = await Hive.openBox<QuoteList>('quoteLists');
    // await box.delete(event.quoteList.name);

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
    // final box = await Hive.openBox<QuoteList>('quoteLists');
    // final updatedList =
    //     updated.firstWhere((l) => l.name == event.quoteList.name);
    // await box.put(updatedList.name, updatedList);
  }

  //? only for hydrated bloc

  @override
  QuoteListState? fromJson(Map<String, dynamic> json) {
    return QuoteListState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(QuoteListState state) {
    return state.toJson();
  }
}
