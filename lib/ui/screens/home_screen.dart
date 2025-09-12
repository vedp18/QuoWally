import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quowally/blocs/quote_bloc/quote_bloc.dart';
import 'package:quowally/blocs/quote_list_bloc/quote_list_bloc.dart';
import 'package:quowally/data/provider/quote_list_provider.dart';
import 'package:quowally/services/native_channel_listner.dart';
import 'package:quowally/ui/screens/auto_change_config_screen.dart';
import 'package:quowally/ui/widgets/copy_share_row.dart';
import 'package:quowally/ui/widgets/custom_bottom_navigation_bar.dart';
import 'package:quowally/ui/widgets/qoute_styling_list_tile.dart';
import 'package:quowally/ui/widgets/quote_preview.dart';
import 'package:quowally/utils/custom_logger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int rebuild = 0;

  late final QuoteListProvider quoteListProvider;

  Color _backgroundColor = Colors.white;
  TextAlign textAlign = TextAlign.center;

  @override
  void initState() {
    super.initState();
    quoteListProvider = QuoteListProvider(context.read<QuoteListBloc>());
    _loadQuoteLists();

    final quoteBloc = context.read<QuoteBloc>();
    NativeChannelListener.register(quoteBloc);

    // print("hello:  ${context.read<QuoteListBloc>().state.lists.first.quotes.length}");
  }

  Future<void> _loadQuoteLists() async {
    final bloc = context.read<QuoteListBloc>();
    // final provider = QuoteListProvider(bloc);

    // Load prebuilt lists (from BLoC initial state)
    // final prebuiltLists = bloc.state.lists.where((l) => l.isPrebuilt);
    final prebuiltLists = [
      {
        "name": 'QuoWally Quotes',
        "filename": 'assets/quotes/quowallyquotes.json',
      },
      {
        "name": 'Motivational Quotes',
        "filename": 'assets/quotes/motivationalquotes.json',
      },
      {
        "name": 'Smart Quotes',
        "filename": 'assets/quotes/smartquotes.json',
      },
    ];

    for (final prebuilt in prebuiltLists) {
      await quoteListProvider.loadPrebuiltQuoteList(
        name: prebuilt['name']!,
        filename: prebuilt['filename']!,
      );
    }

    // Load custom lists (also from BLoC)
    final customLists = bloc.state.lists.where((l) => !l.isPrebuilt);
    for (final custom in customLists) {
      await quoteListProvider.loadCustomQuoteList(custom.name);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CustomLogger.logToFile("App started -- Entered into HomeScreen<build>");
    // print(++rebuild);

    // final double dpWd = MediaQuery.of(context).size.width;
    // final double dpHt = MediaQuery.of(context).size.height;

    // final double physicalWd = dpWd * MediaQuery.devicePixelRatioOf(context);
    // final double physicalHt = dpHt * MediaQuery.devicePixelRatioOf(context);

    // print("logical: $dpWd and physical: $physicalWd");
    // print("logical: $dpHt and physical: $physicalHt");

    return Scaffold(
      drawer: Drawer(
        width: 280,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 120,
              child: DrawerHeader(
                child: Text(
                  'QuoWally',
                  style: TextStyle(
                    fontFamily: 'Major Mono Display',
                    color: Colors.brown[800],
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // ListTile(
            //   leading: Icon(Icons.favorite_border),
            //   title: const Text('Favourite Quotes'),
            //   onTap: () => _navigateTo('Favourites', context),
            // ),
            // ListTile(
            //   leading: Icon(Icons.list_alt),
            //   title: const Text('Custom Quote Lists'),
            //   onTap: () => _navigateTo('Custom Lists', context),
            // ),
            ListTile(
                leading: Icon(Icons.schedule),
                title: const Text('Set Auto Change Quote'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AutoChangeConfigScreen(),
                    ),
                  );
                }),
          ],
        ),
      ),
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        scrolledUnderElevation: 0,
        title: const Text("QuoWally"),
        foregroundColor: Colors.brown[800],
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontFamily: 'Major Mono Display',
              color: Colors.brown[800],
              fontSize: 24,
              fontWeight: FontWeight.bold),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Quote Preview
            QuotePreview(),

            // Row --> copy and share
            CopyShareRow(),

            // Quote-Author Styling List
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6.0),
                child: QuoteStylingList(),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
