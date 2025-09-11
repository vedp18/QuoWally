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
          // centerTitle: true,
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
          final customQuoteLists = state.lists.where((list) => !list.isPrebuilt).toList();

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
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.brown[100]!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          quoteList.name,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "- ${quoteList.quotes.length}",
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }));
  }
}
