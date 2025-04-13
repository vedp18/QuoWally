import 'dart:ui';
import 'package:flutter_quote_wallpaper_app/models/quote.dart';

class Wallpaper {
  final Color wallpaperColor;
  Quote? quote;

  Wallpaper({
    this.wallpaperColor = const Color.fromARGB(255, 29, 19, 17),
    this.quote,
  });
}
