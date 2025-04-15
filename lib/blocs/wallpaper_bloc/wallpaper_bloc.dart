

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quote_wallpaper_app/models/wallpaper.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc extends HydratedBloc<WallpaperEvent, WallpaperState> {
  WallpaperBloc() : super(WallpaperState(wallpaper: Wallpaper())) {
    on<WallpaperColorChangedEvent>((event, emit) {
      emit(WallpaperState(wallpaper: Wallpaper(wallpaperColor: event.newWallpaperColor)));
    });
  }
  
  @override
  WallpaperState? fromJson(Map<String, dynamic> json) {
    // print("from wallpaper fromjson");
    // print(json);

    return WallpaperState.fromMap(json);
  }
  
  @override
  Map<String, dynamic>? toJson(WallpaperState state) {
    // print("from wallpaper tojson");
    // print(state.toMap());
    return state.toMap();
  }
}
