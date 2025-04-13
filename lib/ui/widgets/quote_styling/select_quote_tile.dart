import 'package:flutter/material.dart';
import 'package:flutter_quote_wallpaper_app/ui/screens/quotes_list_screen.dart';

class SelectQuoteTile extends StatelessWidget {
  const SelectQuoteTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Select Quote: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown[500],
                fontSize: 11,
              ),
              children: [
                TextSpan(
                  text: 'Select quote from any List.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.brown[300],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Wrap(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      // fixedSize: Size(100, 10),
                      minimumSize: Size(0, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      side: BorderSide(color: Colors.brown[50]!)),
                  onPressed: () {},
                  child: Text("Select Random Quote"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      // fixedSize: Size(100, 10),
                      minimumSize: Size(0, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      side: BorderSide(color: Colors.brown[50]!)),
                  onPressed: () {},
                  child: Text("Favourite Quotes"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      // fixedSize: Size(100, 10),
                      minimumSize: Size(100, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      side: BorderSide(color: Colors.brown[50]!)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuotesListScreen(),
                      ),
                    );
                  },
                  child: Text("QuoWally Quotes"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}