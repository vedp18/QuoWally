import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quowally/blocs/quote_bloc/quote_bloc.dart';
import 'package:quowally/services/native_channel_listner.dart';
import 'package:quowally/ui/screens/auto_change_config_screen.dart';
import 'package:quowally/ui/screens/custom_quote_lists_screen.dart';
import 'package:quowally/ui/screens/favourite_quotes_screen.dart';
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

  // late final QuoteListProvider quoteListProvider;

  final Color _backgroundColor = Colors.white;
  TextAlign textAlign = TextAlign.center;

  @override
  void initState() {
    super.initState();
    // quoteListProvider = QuoteListProvider(context.read<QuoteListBloc>());
    // _loadQuoteLists();

    final quoteBloc = context.read<QuoteBloc>();
    NativeChannelListener.register(quoteBloc);
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

    return SafeArea(
      top: false,
      child: Scaffold(
        drawer: Drawer(
          width: 280,
          child: Column(
            children: [
              SizedBox(
                height: 120,
                child: DrawerHeader(
                  child: Align(
                    alignment: Alignment.centerLeft,
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
              ),
              Column(
                children: [
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
                  ListTile(
                      leading: Icon(Icons.notes),
                      title: const Text('Custom Lists'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomQuoteListsScreen(),
                          ),
                        );
                      }),
                  ListTile(
                      leading: Icon(Icons.favorite_border),
                      title: const Text('Favourite Quotes'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavouriteQuotesScreen(),
                          ),
                        );
                      }),
                ],
              ),
              // To cover between spaces
              Spacer(),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Developer Signature
                    const Text(
                      "Developed by Vedkumar Patel",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),

                    // vspace
                    const SizedBox(height: 2),

                    // version info
                    Text(
                      "Version 1.0.0+1",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),

                    // vspace
                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      "Contact me through",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    // vspace
                    const SizedBox(
                      height: 8,
                    ),

                    // social icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: SvgPicture.asset(
                            "assets/icons/github.svg",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: SvgPicture.asset(
                            "assets/icons/linkedin.svg",
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: SvgPicture.asset("assets/icons/twitter-x.svg"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // const Spacer(),
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
      ),
    );
  }
}
