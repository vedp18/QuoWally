import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quote_wallpaper_app/app_bloc_oberver.dart';
import 'package:flutter_quote_wallpaper_app/blocs/quote_bloc/quote_bloc.dart';
import 'package:flutter_quote_wallpaper_app/blocs/wallpaper_bloc/wallpaper_bloc.dart';
import 'package:flutter_quote_wallpaper_app/ui/screens/home_screen.dart';
// import 'package:flutter_quote_wallpaper_app/qoute.dart';

void main() {

  Bloc.observer = AppBlocObserver();
  runApp(QuoteWallpaperApp());
}

class QuoteWallpaperApp extends StatelessWidget {
  const QuoteWallpaperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => QuoteBloc(),
        ),

        BlocProvider(
          create: (_) => WallpaperBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Quote Wallpaper",
        theme: ThemeData(colorSchemeSeed: Colors.brown[600]),

        // home: QuoteWallpaperApp2(),
        home: HomeScreen(),
      ),
    );
  }
}
