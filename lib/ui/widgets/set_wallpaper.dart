// ignore_for_file: constant_identifier_names
import 'package:wallpaper_plugin/wallpaper_plugin.dart';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quowally/models/quote.dart';
import 'package:quowally/models/wallpaper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;

class SetWallPaper {
  static const int FLAG_LOCK_SCREEN = 1;
  static const int FLAG_HOME_SCREEN = 2;
  static const int FLAG_BOTH_SCREEN = 3;

  // final TextEditingController _controller = TextEditingController();
  // String _quote = "";

  // static const platform = MethodChannel("wallpaper_channel");
  static const platform = MethodChannel("wallpaper_channel");

  static Future<void> setWallpaper({
    required final double wd,
    required final double ht,
    required final int which,
    // required final Quote quote,
    required final Wallpaper wallpaper,
    // required final TextAlign textAlign,
  }) async {
    final Quote quote = wallpaper.quote!;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, wd, ht));

    // Background Color
    ///* Paint paint = Paint()..color = const Color.fromARGB(255, 29, 19, 17);
    Paint paint = Paint()..color = wallpaper.wallpaperColor;

    canvas.drawRect(Rect.fromLTWH(0, 0, wd, ht), paint);

    // quote painter
    final quotePainter = TextPainter(
      text: TextSpan(
        text: quote.quote,
        style: TextStyle(
          fontFamily: quote.quoteStyle.quoteFont,
          height: 1.2,
          color: quote.quoteStyle.quoteColor,
          fontSize: quote.quoteStyle.quoteSize * 3,
          fontStyle: quote.quoteStyle.quoteFontStyle,
          fontWeight: quote.quoteStyle.quoteWeight,
        ),
      ),
      textAlign: quote.quoteStyle.quoteAlignment,
      textDirection: TextDirection.ltr,
    );

    quotePainter.layout(minWidth: 0, maxWidth: (wd - 240));

    double dx;
    if (quote.quoteStyle.quoteAlignment == TextAlign.center) {
      dx = (wd - quotePainter.width) / 2;
    } else if (quote.quoteStyle.quoteAlignment == TextAlign.right) {
      dx = wd - quotePainter.width - 120; // small padding from right
    } else {
      dx = 120; // left alignment padding
    }

    final double dy = ht * 0.266;
    quotePainter.paint(canvas, Offset(dx, dy));

    final authorAlignment = quote.authorStyle.authorAlignment;
    // author painter
    final authorPainter = TextPainter(
      text: TextSpan(
        text: "- ${quote.author}",
        style: TextStyle(
          fontFamily: quote.authorStyle.authorFont,
          height: 1.2,
          color: quote.quoteStyle.quoteColor,
          fontSize: quote.authorStyle.authorSize * 3,
          fontStyle: quote.authorStyle.authorFontStyle,
          fontWeight: quote.authorStyle.authorWeight,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    authorPainter.layout(minWidth: 0, maxWidth: wd - 120); // keep side padding

    // Convert Alignment to dx offset
    double authorDx;
    if (authorAlignment == Alignment.center || authorAlignment.x == 0) {
      authorDx = (wd - authorPainter.width) / 2;
    } else if (authorAlignment.x > 0) {
      authorDx = wd - authorPainter.width - 120;
    } else {
      authorDx = 120;
    }

    final double authorDy = dy + quotePainter.height + 30; // below quote
    authorPainter.paint(canvas, Offset(authorDx, authorDy));

    // final painting on wallpaper
    final picture = recorder.endRecording();
    final img = await picture.toImage(wd.toInt(), ht.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    final directory = await getApplicationDocumentsDirectory();
    print(directory);
    final file = File('${directory.path}/wallpaper.png');
    print(file.path);
    await file.writeAsBytes(pngBytes);
    print("wallpaper written");

    try {
      print("inside try");

      await WallpaperPlugin.startWallpaperWorker(
        filePath: file.path,
        which: which, // or 1 for lock, 3 for both
      );

      // Call the native Kotlin method to set wallpaper
      // await platform.invokeMethod("startNativeWallpaperWorker", {
      //   "filePath": file.path,
      //   "which": which,
      // });
      print("method invoked");
    } on PlatformException catch (e) {
      print("Failed to set wallpaper: ${e.message}");
    }
  }
}
