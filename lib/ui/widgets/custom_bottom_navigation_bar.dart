import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/author_bloc/author_bloc.dart';
import 'package:quowally/blocs/quote_bloc/quote_bloc.dart';
import 'package:quowally/blocs/wallpaper_bloc/wallpaper_bloc.dart';
import 'package:quowally/models/quote.dart';
import 'package:quowally/models/wallpaper.dart';
import 'package:quowally/ui/widgets/set_wallpaper.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final double dpWd = MediaQuery.of(context).size.width;
    final double dpHt = MediaQuery.of(context).size.height;

    final double physicalWd = dpWd * MediaQuery.devicePixelRatioOf(context);
    final double physicalHt = dpHt * MediaQuery.devicePixelRatioOf(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildCustomButton(
            icon: Icons.screen_lock_portrait_sharp,
            size: 27,
            onPressed: () {
              SetWallPaper.setWallpaper(
                wd: physicalWd,
                ht: physicalHt,
                which: SetWallPaper.FLAG_LOCK_SCREEN,
                // quote: currentQuote,
                wallpaper: _getUpdatedWallpaper(context),
                // textAlign: textAlign,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(milliseconds: 540),
                  elevation: 5,
                  backgroundColor: Colors.brown[50],
                  behavior: SnackBarBehavior.floating,
                  width: 300,
                  // margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  // backgroundColor: ,
                  content: Center(
                    child: Text(
                      "Wallpaper set on Lock Screen",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              );
            },
          ),
          _buildCustomButton(
            icon: Icons.home_outlined,
            size: 30,
            onPressed: () {
              // currentQuote.authorStyle = currentAuthorStyle;
              // currentWallpaper.quote = currentQuote;
              SetWallPaper.setWallpaper(
                wd: physicalWd,
                ht: physicalHt,
                which: SetWallPaper.FLAG_HOME_SCREEN,
                // quote: currentQuote,
                wallpaper: _getUpdatedWallpaper(context),
                // textAlign: textAlign,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(milliseconds: 540),
                  elevation: 5,
                  backgroundColor: Colors.brown[50],
                  behavior: SnackBarBehavior.floating,
                  width: 300,
                  // margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  // backgroundColor: ,
                  content: Center(
                    child: Text(
                      "Wallpaper set on Home Screen",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              );
            },
          ),
          _buildCustomButton(
            text: "BOTH",
            icon: null,
            size: 19,
            onPressed: () {
              // currentQuote.authorStyle = currentAuthorStyle;
              // currentWallpaper.quote = currentQuote;
              SetWallPaper.setWallpaper(
                wd: physicalWd,
                ht: physicalHt,
                which: SetWallPaper.FLAG_BOTH_SCREEN,
                // quote: currentQuote,
                wallpaper: _getUpdatedWallpaper(context),
                // textAlign: textAlign,
              );

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(milliseconds: 540),
                  elevation: 5,
                  backgroundColor: Colors.brown[50],
                  behavior: SnackBarBehavior.floating,
                  width: 300,
                  // margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  // backgroundColor: ,
                  content: Center(
                    child: Text(
                      "Wallpaper set on both Screens",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Wallpaper _getUpdatedWallpaper(BuildContext context) {
    final Quote currentQuote = context.read<QuoteBloc>().state.updatedQuote;
    currentQuote.authorStyle =
        context.read<AuthorBloc>().state.updatedAuthorStyle;
    final currentWallpaper = context.read<WallpaperBloc>().state.wallpaper;
    currentWallpaper.quote = currentQuote;

    return currentWallpaper;
  }

  Widget _buildCustomButton({
    String? text,
    required IconData? icon,
    required double size,
    required Function onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
      ),
      onPressed: () => onPressed(),
      child: SizedBox(
        height: 55,
        width: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 3,
          children: [
            (text == null)
                ? Icon(
                    icon,
                    size: size,
                  )
                : Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'Rubik Doodle Shadow',
                      fontSize: size,
                      fontWeight: FontWeight.bold,
                      height: 1.6,
                    ),
                  ),
            Text(
              "Set As",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
