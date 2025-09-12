import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/quote_list_bloc/quote_list_bloc.dart';
import 'package:quowally/ui/screens/quotes_list_screen.dart';
import 'package:quowally/ui/widgets/add_custom_list.dart';

class CustomQuoteListsScreen extends StatelessWidget {
  const CustomQuoteListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Text("Custom QuoteLists"),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: AddCustomList(),
                  ),
                );
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: BlocBuilder<QuoteListBloc, QuoteListState>(
        builder: (context, state) {
          final customQuoteLists =
              state.lists.where((list) => !list.isPrebuilt).toList();

          if (customQuoteLists.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 30,
              ),
              child: Text(
                "No QuoteLists created yet. \n Create through add button in Top-Right Corner.",
                style: TextStyle(
                  color: Colors.brown[100],
                  fontSize: 25,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            itemCount: customQuoteLists.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final quoteList = customQuoteLists[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuotesListScreen(quoteList: quoteList),
                    ),
                  );
                },
                // QuoteList Card
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.brown[100]!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row: QuoteList Name + Delete button
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // QuoteList name
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                quoteList.name,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),

                          // Delete button
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              // SnackBar to show QuoteList Deleted
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(milliseconds: 540),
                                  elevation: 5,
                                  backgroundColor: Colors.brown[50],
                                  behavior: SnackBarBehavior.floating,
                                  width: 200,
                                  // margin: EdgeInsets.all(10),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  // backgroundColor: ,
                                  content: Center(
                                    child: Text(
                                      "QuoteList Deleted",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                  ),
                                ),
                              );

                              // Add event to Delete QuoteList
                              context
                                  .read<QuoteListBloc>()
                                  .add(DeleteQuoteList(quoteList: quoteList));
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      // total quotes aligned to extreme right of card
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0, bottom: 7),
                          child: Text(
                            "total quotes - ${quoteList.quotes.length}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
