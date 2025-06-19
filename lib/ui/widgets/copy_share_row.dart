import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/quote_bloc/quote_bloc.dart';

class CopyShareRow extends StatelessWidget {
  const CopyShareRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          ),
          onPressed: () async {
            final messenger = ScaffoldMessenger.of(context);
            final currentQuote = context.read<QuoteBloc>().state.updatedQuote;
            await Clipboard.setData(ClipboardData(text: currentQuote.quote));

            messenger.showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text("Quote copied to clipboard"),
              ),
            );
            messenger.deactivate();
          },
          child: Text(
            "Copy",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          ),
          onPressed: () {},
          child: Text(
            "Share",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
