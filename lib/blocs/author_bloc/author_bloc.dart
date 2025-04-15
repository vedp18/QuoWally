import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quote_wallpaper_app/models/author_style.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'author_event.dart';
part 'author_state.dart';

class AuthorBloc extends HydratedBloc<AuthorEvent, AuthorState> {
  AuthorBloc() : super(AuthorState(updatedAuthorStyle: AuthorStyle())) {
    // on<AuthorChangedEvent>(_onAuthorChangedEvent);
    // on<AuthorColorChangedEvent>(_onAuthorColorChangedEvent);
    on<AuthorFontChangedEvent>(_onAuthorFontChangedEvent);
    on<AuthorFontStyleChangedEvent>(_onAuthorFontStyleChangedEvent);
    on<AuthorSizeChangedEvent>(_onAuthorSizeChangedEvent);
    on<AuthorWeightChangedEvent>(_onAuthorWeightChangedEvent);
    on<AuthorAlignmentChangedEvent>(_onAuthorAlignmentChangedEvent);
  }

  // changing quote font
  void _onAuthorFontChangedEvent(
    AuthorFontChangedEvent event,
    Emitter<AuthorState> emit,
  ) {
    final AuthorStyle currentAuthorStyle = state.updatedAuthorStyle;

    final updatedAuthorStyle =
        currentAuthorStyle.copyWith(authorFont: event.newFont);

    emit(AuthorState(updatedAuthorStyle: updatedAuthorStyle));
  }

  // changing quote font style
  void _onAuthorFontStyleChangedEvent(
    AuthorFontStyleChangedEvent event,
    Emitter<AuthorState> emit,
  ) {
    final AuthorStyle currentAuthorStyle = state.updatedAuthorStyle;

    final updatedAuthorStyle =
        currentAuthorStyle.copyWith(authorFontStyle: event.newFontStyle);

    emit(AuthorState(updatedAuthorStyle: updatedAuthorStyle));
  }

  // changing quote size
  void _onAuthorSizeChangedEvent(
    AuthorSizeChangedEvent event,
    Emitter<AuthorState> emit,
  ) {
    final AuthorStyle currentAuthorStyle = state.updatedAuthorStyle;

    final updatedAuthorStyle =
        currentAuthorStyle.copyWith(authorSize: event.newSize);

    emit(AuthorState(updatedAuthorStyle: updatedAuthorStyle));
  }

  // changing quote size
  void _onAuthorWeightChangedEvent(
    AuthorWeightChangedEvent event,
    Emitter<AuthorState> emit,
  ) {
    final AuthorStyle currentAuthorStyle = state.updatedAuthorStyle;

    final updatedAuthorStyle =
        currentAuthorStyle.copyWith(authorWeight: event.newWeight);

    emit(AuthorState(updatedAuthorStyle: updatedAuthorStyle));
  }

  // changing quote alignment
  void _onAuthorAlignmentChangedEvent(
    AuthorAlignmentChangedEvent event,
    Emitter<AuthorState> emit,
  ) {
    final AuthorStyle currentAuthorStyle = state.updatedAuthorStyle;

    final updatedAuthorStyle =
        currentAuthorStyle.copyWith(authorAlignment: event.newAlignment);

    emit(AuthorState(updatedAuthorStyle: updatedAuthorStyle));
  }

  @override
  AuthorState? fromJson(Map<String, dynamic> json) {
    // print("authorbloc - fromjson");
    // print(json);
    return AuthorState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthorState state) {
    // print("authorbloc - tojson");
    // print(state.toMap());
    return state.toMap();
  }

  // helper method to get current AuthorStyle with its properties
  // AuthorStyle _getCurrentAuthorStyle(State state) {
  //   return ;
  // }
}
