

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quote_wallpaper_app/models/wallpaper.dart';

part 'wallpaper_event.dart';
part 'wallpaper_state.dart';

class WallpaperBloc extends Bloc<WallpaperEvent, WallpaperState> {
  WallpaperBloc() : super(WallpaperState(wallpaper: Wallpaper())) {
    on<WallpaperColorChangedEvent>((event, emit) {
      emit(WallpaperState(wallpaper: Wallpaper(background: event.newWallpaperColor)));
    });
  }
}
