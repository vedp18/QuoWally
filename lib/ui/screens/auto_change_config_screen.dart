import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quowally/blocs/auto_change_quote_bloc/auto_change_quote_bloc.dart';
import 'package:quowally/models/quote_list.dart';
import 'package:quowally/services/auto_change_scheduler_service.dart';
import 'package:quowally/ui/widgets/copy_share_row.dart';
import 'package:quowally/ui/widgets/qoute_styling_list_tile.dart';
import 'package:quowally/ui/widgets/quote_preview.dart';
import 'package:quowally/utils/custom_logger.dart';

class AutoChangeConfigScreen extends StatelessWidget {
  const AutoChangeConfigScreen({super.key});

  final Color _backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    // Density Pixel sizes of Device
    final double dpWd = MediaQuery.of(context).size.width;
    final double dpHt = MediaQuery.of(context).size.height;

    // Physical sizes of Device
    final double physicalWd = dpWd * MediaQuery.devicePixelRatioOf(context);
    final double physicalHt = dpHt * MediaQuery.devicePixelRatioOf(context);

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: _backgroundColor,
        appBar: AppBar(
          backgroundColor: _backgroundColor,
          scrolledUnderElevation: 0,
          foregroundColor: Colors.brown[800],
          titleTextStyle: TextStyle(
            fontFamily: 'Domine',
            color: Colors.brown[800],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          title: const Text("Auto Change Quote"),
          actions: [
            BlocBuilder<AutoChangeQuoteBloc, AutoChangeQuoteState>(
              builder: (context, state) {
                return FlutterSwitch(
                  width: 45,
                  height: 23,
                  toggleSize: 15,
                  activeColor: Colors.brown,
                  inactiveColor: Colors.grey,
                  value: state.isEnabled,
                  onToggle: (value) {
                    context
                        .read<AutoChangeQuoteBloc>()
                        .add(ToggleAutoChange(enabled: value));
                  },
                );
              },
            ),
            SizedBox(
              width: 30,
            ),
          ],
        ),
        body: BlocBuilder<AutoChangeQuoteBloc, AutoChangeQuoteState>(
          builder: (context, state) {
            return AbsorbPointer(
              absorbing: !state.isEnabled, // disable interactivity
              child: Opacity(
                opacity: state.isEnabled ? 1.0 : 0.5, // dim when disabled
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Quote Preview
                      QuotePreview(),

                      // Row --> copy and share
                      CopyShareRow(),

                      // Quote Styling
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6.0),
                          child: QuoteStylingList(
                            fromAutoChange: true,
                          ),
                        ),
                      ),

                      BlocSelector<AutoChangeQuoteBloc, AutoChangeQuoteState,
                          QuoteList>(
                        selector: (state) {
                          return state.selectedQuoteList;
                        },
                        builder: (context, quoteList) {
                          return AbsorbPointer(
                            absorbing:
                                (state.selectedQuoteList.name == "Select List"),
                            child: Opacity(
                              opacity: !(state.selectedQuoteList.name ==
                                      "Select List")
                                  ? 1.0
                                  : 0.5, // dim when disabled
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(270, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  onPressed: () {
                                    if (state.isEnabled) {
                                      CustomLogger.logToFile(
                                          "Save Changes tapped");

                                      AutoChangeSchedulerService
                                          .scheduleAutoChangeTask(
                                        quoteIndex:
                                            state.selectedQuoteList.quoteIndex,
                                        intervalInMinutes:
                                            state.interval.inMinutes,
                                        physicalHt: physicalHt,
                                        physicalWd: physicalWd,
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          duration: Duration(milliseconds: 540),
                                          elevation: 5,
                                          backgroundColor: Colors.brown[50],
                                          behavior: SnackBarBehavior.floating,
                                          width: 300,
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(9),
                                          ),
                                          content: Center(
                                            child: Text(
                                              "Auto change Quote is Enabled",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    "Save Changes",
                                    style: GoogleFonts.andika(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
