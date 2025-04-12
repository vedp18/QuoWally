import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quote_wallpaper_app/models/quote.dart';
import 'package:flutter_quote_wallpaper_app/models/wallpaper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;

class SetWallPaper {
  static final int FLAG_LOCK_SCREEN = 1;
  static final int FLAG_HOME_SCREEN = 2;
  static final int FLAG_BOTH_SCREEN = 3;

  // final TextEditingController _controller = TextEditingController();
  // String _quote = "";
  static const platform = MethodChannel("wallpaper_channel");

  static Future<void> setWallpaper({
    required final double wd,
    required final double ht,
    required final int which,
    // required final Quote quote,
    required final Wallpaper wallpaper,
    required final TextAlign textAlign,
  }) async {
    final Quote quote = wallpaper.quote!;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, wd, ht));

    // Background Color
    ///* Paint paint = Paint()..color = const Color.fromARGB(255, 29, 19, 17);
    Paint paint = Paint()..color = wallpaper.background;

    canvas.drawRect(Rect.fromLTWH(0, 0, wd, ht), paint);

    // quote painter
    final quotePainter = TextPainter(
      text: TextSpan(
        text: quote.quote,
        style: GoogleFonts.getFont(
          quote.quoteStyle.quoteFont,
          textStyle: TextStyle(
            height: 1.2,
            color: quote.quoteStyle.quoteColor,
            fontSize: quote.quoteStyle.quoteSize * 3,
            fontStyle: quote.quoteStyle.quoteFontStyle,
            fontWeight: quote.quoteStyle.quoteWeight,
          ),
        ),
      ),
      textAlign: quote.quoteStyle.quoteAlignment,
      textDirection: TextDirection.ltr,
    );

    quotePainter.layout(minWidth: 0, maxWidth: (wd - 240));

    double dx;
    if (textAlign == TextAlign.center) {
      dx = (wd - quotePainter.width) / 2;
    } else if (textAlign == TextAlign.right) {
      dx = wd - quotePainter.width - 120; // small padding from right
    } else {
      dx = 120; // left alignment padding
    }

    final double dy = ht * 0.266;
    quotePainter.paint(canvas, Offset(dx, dy));



    final authorAlignment = Alignment.bottomRight;
    // final authorAlignment = quote.authorStyle.quoteAlignment;
    // auther painter
    final authorPainter = TextPainter(
      text: TextSpan(
        text: "- ${quote.author}",
        style: GoogleFonts.getFont(
          quote.authorStyle!.authorFont,
          textStyle: TextStyle(
            height: 1.2,
            color: quote.quoteStyle.quoteColor,
            fontSize: quote.authorStyle!.authorSize * 3,
            fontStyle: quote.authorStyle!.authorFontStyle,
            fontWeight: quote.authorStyle!.authorWeight,
          ),
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

    try {
      // Call the native Kotlin method to set wallpaper
      final String result = await platform.invokeMethod(
          "setWallpaper", {"filePath": file.path, "which": which});
      print(result);
    } on PlatformException catch (e) {
      print("Failed to set wallpaper: ${e.message}");
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   final double physicalWd = View.of(context).physicalSize.width;
  //   final double physicalHt = View.of(context).physicalSize.height;
  //   print(physicalWd);

  //   return Scaffold(
  //     backgroundColor: Colors.grey[900],
  //     appBar: AppBar(
  //       title: Text(
  //         "Quote Wallpaper",
  //         style: GoogleFonts.cormorantUpright(
  //           textStyle: TextStyle(
  //             fontSize: 22,
  //           ),
  //         ),
  //       ),
  //     ),
  //     body: Center(
  //       child: Padding(
  //         padding: const EdgeInsets.all(20.0),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             TextField(
  //               controller: _controller,
  //               style: TextStyle(color: Colors.white),
  //               decoration: InputDecoration(
  //                 labelText: "Enter Quote",
  //                 labelStyle: TextStyle(color: Colors.white),
  //                 enabledBorder: OutlineInputBorder(
  //                   borderSide: BorderSide(color: Colors.white),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             ElevatedButton(
  //               onPressed: () {
  //                 setState(() {
  //                   _quote = _controller.text;
  //                 });
  //                 setWallpaper(
  //                     wd: physicalWd, ht: physicalHt, which: FLAG_LOCK_SCREEN);
  //               },
  //               child: Text("Set as Lock Screen"),
  //             ),
  //             ElevatedButton(
  //               onPressed: () {
  //                 setState(() {
  //                   _quote = _controller.text;
  //                 });
  //                 setWallpaper(
  //                     wd: physicalWd, ht: physicalHt, which: FLAG_HOME_SCREEN);
  //               },
  //               child: Text("Set as Home Screen"),
  //             ),
  //             ElevatedButton(
  //               onPressed: () {
  //                 setState(() {
  //                   _quote = _controller.text;
  //                 });
  //                 setWallpaper(
  //                     wd: physicalWd, ht: physicalHt, which: FLAG_BOTH_SCREEN);
  //               },
  //               child: Text("Set as Both"),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
