import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/quote_bloc/quote_bloc.dart';

class AddCustomQuote extends StatefulWidget {
  final Function(BuildContext, String quote, String author) onSave;
  final String? currentQuote;
  final String? currentAuthor;

  const AddCustomQuote(
      {super.key, required this.onSave, this.currentQuote, this.currentAuthor});

  @override
  State<AddCustomQuote> createState() => _AddCustomQuoteState();
}

class _AddCustomQuoteState extends State<AddCustomQuote> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _quoteController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  @override
  void initState() {
    _quoteController.text = widget.currentQuote ?? '';
    _authorController.text = widget.currentAuthor ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _quoteController.dispose();
    _authorController.dispose();
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
              controller: _quoteController,
              decoration: const InputDecoration(
                labelText: 'Enter your quote',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? 'Quote cannot be empty'
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _authorController,
              decoration: const InputDecoration(
                labelText: 'Author (optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final newQuoteText = _quoteController.text.trim();
                  final newAuthorText = _authorController.text.trim();

                  widget.onSave(context, newQuoteText, newAuthorText);

                  Navigator.pop(context);
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
