import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quowally/app_bloc_oberver.dart';
import 'package:quowally/blocs/author_bloc/author_bloc.dart';
import 'package:quowally/blocs/auto_change_quote_bloc/auto_change_quote_bloc.dart';
import 'package:quowally/blocs/quote_bloc/quote_bloc.dart';
import 'package:quowally/blocs/quote_list_bloc/quote_list_bloc.dart';
import 'package:quowally/blocs/wallpaper_bloc/wallpaper_bloc.dart';
import 'package:quowally/ui/screens/home_screen.dart';
// import 'package:quowally/qoute.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory(
          (await getApplicationDocumentsDirectory()).path));

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
        BlocProvider(
          create: (_) => AuthorBloc(),
        ),
        BlocProvider(
          create: (_) => AutoChangeQuoteBloc(),
        ),
        BlocProvider(
          create: (_) => QuoteListBloc(),
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
