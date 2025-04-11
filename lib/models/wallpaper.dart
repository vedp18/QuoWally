import 'dart:ui';
import 'package:flutter_quote_wallpaper_app/models/quote.dart';

class Wallpaper {
  final Color background;
  Quote? quote;

  Wallpaper({
    this.background = const Color.fromARGB(255, 29, 19, 17),
    this.quote,
  });
}
