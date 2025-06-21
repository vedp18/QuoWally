// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'wallpaper_bloc.dart';

@immutable
class WallpaperState {
  final Wallpaper wallpaper;
  const WallpaperState({required this.wallpaper});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'wallpaper': wallpaper.toMap(),
    };
  }

  factory WallpaperState.fromMap(Map<String, dynamic> map) {
    return WallpaperState(
      wallpaper: Wallpaper.fromMap((map["wallpaper"]?? Map<String,dynamic>.from({})) as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory WallpaperState.fromJson(String source) => WallpaperState.fromMap(json.decode(source) as Map<String, dynamic>);

  WallpaperState copyWith({
    Wallpaper? wallpaper,
  }) {
    return WallpaperState(
      wallpaper: wallpaper ?? this.wallpaper,
    );
  }
}



