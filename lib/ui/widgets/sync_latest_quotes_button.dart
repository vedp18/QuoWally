import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/quote_list_bloc/quote_list_bloc.dart';

class SyncLatestQuotesButton extends StatelessWidget {
  const SyncLatestQuotesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuoteListBloc, QuoteListState>(
      listenWhen: (previous, current) =>
          previous.quoteListStatus != current.quoteListStatus,
      listener: (context, state) {
        final messenger = ScaffoldMessenger.of(context);
        if (state.quoteListStatus == QuoteListStatus.success) {
          messenger.showSnackBar(
            const SnackBar(
              content: Text("Quotes synced successfully!"),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 2),
            ),
          );
        } else if (state.quoteListStatus == QuoteListStatus.failure) {
          messenger.showSnackBar(
            const SnackBar(
              content:
                  Text("Failed to sync quotes. Check internet connection."),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      child: BlocBuilder<QuoteListBloc, QuoteListState>(
        builder: (context, state) {
          final isLoading = state.quoteListStatus == QuoteListStatus.loading;

          return Center(
            child: Container(
              width: 270,
              margin: EdgeInsets.only(top: 18, bottom: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
                onPressed: isLoading
                    ? null
                    : () {
                        context
                            .read<QuoteListBloc>()
                            .add(SyncQuoteListsEvent());
                      },
                child: SizedBox(
                  height: 36,
                  child: Center(
                    child: isLoading
                        ? const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          )
                        : const Text(
                            "Sync Latest Quotes",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
