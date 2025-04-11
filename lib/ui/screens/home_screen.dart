import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quote_wallpaper_app/blocs/quote_bloc/quote_bloc.dart';
import 'package:flutter_quote_wallpaper_app/blocs/wallpaper_bloc/wallpaper_bloc.dart';
import 'package:flutter_quote_wallpaper_app/models/quote_style.dart';
import 'package:flutter_quote_wallpaper_app/models/wallpaper.dart';
import 'package:flutter_quote_wallpaper_app/ui/widgets/set_wallpaper.dart';
import 'package:flutter_quote_wallpaper_app/models/quote.dart';
import 'package:flutter_quote_wallpaper_app/ui/widgets/qoute_list_tile.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late Quote currentQuote;
  // Quote(
  //     quote:
  //         // "11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111",
  //         "ॐ असतो मा सद्गमय ।\nतमसो मा ज्योतिर्गमय ।\nमृत्योर्मा अमृतं गमय ।\nॐ शान्तिः शान्तिः शान्तिः ॥",
  //     author: "Brihadaranyaka Upanishad",
  //     quoteStyle: QuoteStyle());
  // String _currentQuote = "Be yourself; everyone else is already taken.";

  Color _backgroundColor = Colors.white;
  TextAlign textAlign = TextAlign.center;

  void _navigateTo(String route, BuildContext context) {
    Navigator.pop(context); // Close the drawer
    // Implement navigation logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Navigated to $route")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double physicalWd = View.of(context).physicalSize.width;
    final double physicalHt = View.of(context).physicalSize.height;

    final currentQuote = context.select<QuoteBloc, Quote>((bloc) {
      final state = bloc.state;
      if (state is QuoteUpdated) return state.updatedQuote;
      if (state is QuoteInitial) return state.quote;
      return Quote(quote: "Error fetching quote", quoteStyle: QuoteStyle());
    });

    final currentWallpaper = context.select<WallpaperBloc, Wallpaper>((bloc) {
      final state = bloc.state;
      return state.wallpaper;
    });

    return Scaffold(
      drawer: Drawer(
        width: 280,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 100,
              child: DrawerHeader(
                child: Text(
                  'Quote Wallpaper',
                  style: GoogleFonts.lato(
                    color: Colors.brown[500],
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.favorite_border),
              title: const Text('Favourite Quotes'),
              onTap: () => _navigateTo('Favourites', context),
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: const Text('Custom Quote Lists'),
              onTap: () => _navigateTo('Custom Lists', context),
            ),
            ListTile(
              leading: Icon(Icons.schedule),
              title: const Text('Set Auto Change Quote'),
              onTap: () => _navigateTo('Auto Change', context),
            ),
          ],
        ),
      ),
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        scrolledUnderElevation: 0,
        title: const Text("Quote Wallpaper"),
        foregroundColor: Colors.brown[800],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Quote Preview
            Container(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
              decoration: BoxDecoration(
                color: currentWallpaper.background,
                // color: Colors.brown[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                spacing: 3,
                children: [

                  
                  Text(
                    currentQuote.quote,
                    style: GoogleFonts.getFont(
                      currentQuote.quoteStyle.quoteFont,
                      textStyle: TextStyle(
                        height: 1.2,
                        fontSize: currentQuote.quoteStyle.quoteSize,
                        fontStyle: currentQuote.quoteStyle.quoteFontStyle,
                        fontWeight: currentQuote.quoteStyle.quoteWeight,
                        color: currentQuote.quoteStyle.quoteColor,
                      ),
                    ),
                    textAlign: currentQuote.quoteStyle.quoteAlignment,
                  ),

                  // Text(
                  //   currentQuote.quote,
                  //   style: GoogleFonts.tiroDevanagariSanskrit(
                  //       height: 1.2,
                  //       fontSize: 16,
                  //       fontWeight: FontWeight.w600,
                  //       color: Colors.brown[800]),
                  // ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "-  ${currentQuote.author}",
                      style: GoogleFonts.tangerine(
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[900]),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Row --> copy and share
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  ),
                  onPressed: () async {
                    final messenger = ScaffoldMessenger.of(context);

                    await Clipboard.setData(
                        ClipboardData(text: currentQuote.quote));

                    messenger.showSnackBar(
                      const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text("Quote copied to clipboard"),
                      ),
                    );
                    messenger.deactivate();
                  },
                  child: Text(
                    "Copy",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                  ),
                  onPressed: () {},
                  child: Text(
                    "Share",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6.0),
                child: QuoteListTile(
                  currentQuoteStyle: currentQuote.quoteStyle,
                  wallpaperColor: currentWallpaper.background,
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCustomButton(
              icon: Icons.screen_lock_portrait_sharp,
              size: 27,
              onPressed: () {
                
                currentWallpaper.quote = currentQuote;

                SetWallPaper.setWallpaper(
                  wd: physicalWd,
                  ht: physicalHt,
                  which: SetWallPaper.FLAG_LOCK_SCREEN,
                  // quote: currentQuote,
                  wallpaper: currentWallpaper,
                  textAlign: textAlign,
                );
              },
            ),
            _buildCustomButton(
              icon: Icons.home_outlined,
              size: 30,
              onPressed: () {
                currentWallpaper.quote = currentQuote;
                SetWallPaper.setWallpaper(
                  wd: physicalWd,
                  ht: physicalHt,
                  which: SetWallPaper.FLAG_HOME_SCREEN,
                  // quote: currentQuote,
                  wallpaper: currentWallpaper,
                  textAlign: textAlign,
                );
              },
            ),
            _buildCustomButton(
              text: "BOTH",
              icon: null,
              size: 19,
              onPressed: () {
                currentWallpaper.quote = currentQuote;
                SetWallPaper.setWallpaper(
                  wd: physicalWd,
                  ht: physicalHt,
                  which: SetWallPaper.FLAG_BOTH_SCREEN,
                  // quote: currentQuote,
                  wallpaper: currentWallpaper,
                  textAlign: textAlign,
                );
              },
            ),
          ],
        ),
      ),
    );
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
                    style: GoogleFonts.rubikDoodleShadow(
                      textStyle: TextStyle(
                        fontSize: size,
                        fontWeight: FontWeight.bold,
                        height: 1.6,
                      ),
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
