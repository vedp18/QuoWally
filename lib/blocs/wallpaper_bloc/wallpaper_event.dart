part of 'wallpaper_bloc.dart';

@immutable
sealed class WallpaperEvent {}

final class WallpaperColorChangedEvent extends WallpaperEvent{
  final Color newWallpaperColor;
  WallpaperColorChangedEvent({required this.newWallpaperColor});
}
