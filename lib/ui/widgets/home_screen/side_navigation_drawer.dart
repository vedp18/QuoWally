import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quowally/utils/custom_logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../screens/auto_change_config_screen.dart';
import '../../screens/custom_quote_lists_screen.dart';
import '../../screens/favourite_quotes_screen.dart';

class SideNavigationDrawer extends StatelessWidget {
  const SideNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
              // version info
              Text(
                "Version 1.0.0",
                style: const TextStyle(
                  fontFamily: 'Old Standard TT',
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              // vspace
              const SizedBox(height: 2),

              // Developer Signature
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Developed by ",
                    style: TextStyle(
                      fontFamily: 'Sofia',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "Vedkumar",
                    style: TextStyle(
                      fontFamily: 'Arizonia',
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey[600],
                    ),
                  )
                ],
              ),

              // vspace
              const SizedBox(
                height: 20,
              ),

              const Text(
                "Follow me on",
                style: TextStyle(
                  fontFamily: 'Sofia',
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
                  // Github
                  GestureDetector(
                    onTap: () {
                      try {
                        _openGithubProfileURL();
                      } catch (e) {
                        CustomLogger.logToFile(e.toString());
                      }
                    },
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        "assets/icons/github.svg",
                      ),
                    ),
                  ),

                  // Linkedin
                  GestureDetector(
                    onTap: () {
                      try {
                        _openLinkedinProfileURL();
                      } catch (e) {
                        CustomLogger.logToFile(e.toString());
                      }
                    },
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        "assets/icons/linkedin.svg",
                      ),
                    ),
                  ),

                  // Twitter X
                  GestureDetector(
                    onTap: () {
                      try {
                        _openTwitterXProfileURL();
                      } catch (e) {
                        CustomLogger.logToFile(e.toString());
                      }
                    },
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset("assets/icons/twitter-x.svg"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void _openTwitterXProfileURL() async {
  final Uri url = Uri.parse('https://www.x.com/vpx0912');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

void _openLinkedinProfileURL() async {
  final Uri url = Uri.parse('https://www.linkedin.com/in/ved--patel');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

void _openGithubProfileURL() async {
  final Uri url = Uri.parse('https://www.github.com/vedp18');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
