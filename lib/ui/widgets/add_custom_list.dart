import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/quote_list_bloc/quote_list_bloc.dart';
import 'package:quowally/models/quote_list.dart';
import 'package:quowally/ui/screens/quotes_list_screen.dart';

class AddCustomList extends StatefulWidget {

  const AddCustomList({super.key});

  @override
  State<AddCustomList> createState() => _AddCustomListState();
}

class _AddCustomListState extends State<AddCustomList> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _quoteListNameController =
      TextEditingController();

  // void _handleSave() {
  //   if (_formKey.currentState!.validate()) {
  //     widget.onSave(
  //         _quoteController.text.trim(), _authorController.text.trim());
  //     _quoteController.clear();
  //     _authorController.clear();
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Quote saved successfully')),
  //     );
  //   }
  // }

  @override
  void dispose() {
    _quoteListNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _quoteListNameController,
              decoration: const InputDecoration(
                labelText: 'Enter your quote-list name',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name cannot be empty';
                  }

                  final lists = context.read<QuoteListBloc>().state.lists;
                  final exists = lists.any((list) =>
                      list.name.toLowerCase() == value.trim().toLowerCase());

                  if (exists) {
                    return 'A list with this name already exists';
                  }

                  return null;
                }
            ),
            const SizedBox(height: 16),
            // TextFormField(
            //   controller: _authorController,
            //   decoration: const InputDecoration(
            //     labelText: 'Author (optional)',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            // const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // final newQuoteText =
                  //     _quoteListNameController.text.trim();
                  // final newAuthorText =
                  //     _authorController.text.trim();
                  QuoteList newQuoteList = QuoteList(
                      name: _quoteListNameController.text,
                      filename: "",
                      quotes: []);

                  context.read<QuoteListBloc>().add(AddQuoteList(
                        quoteList: newQuoteList,
                      ));

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuotesListScreen(quoteList: newQuoteList),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.save),
              label: const Text('Save'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
