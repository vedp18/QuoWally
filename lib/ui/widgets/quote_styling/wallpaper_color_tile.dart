import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quowally/blocs/wallpaper_bloc/wallpaper_bloc.dart';
import 'package:quowally/utils/quote_styling_values.dart';


class WallpaperColorTile extends StatelessWidget {
  const WallpaperColorTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Wallpaper Color: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.brown[500],
                fontSize: 11,
              ),
              children: [
                TextSpan(
                  text:
                      'Sets the background wallpaper color with the quote and author name. For instance, if you want a dark solid wallpaper then set the color to grey or dark color.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.brown[300],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // spacing: 14,
              children: [
                Text(
                  'Wallpaper Color:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.brown[700],
                  ),
                ),
                BlocSelector<WallpaperBloc, WallpaperState, Color>(
                  selector: (state) {
                    return state.wallpaper.wallpaperColor;
                  },
                  builder: (context, wallpaperColor) {
                    return DropdownButton2<Color>(
                      buttonStyleData: ButtonStyleData(
                        width: 171,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: 150,
                        maxHeight: 300,
                      ),
                      isExpanded: true,
                      // menuWidth: 150,
                      value: wallpaperColor,
                      // context
                      //     .read<WallpaperBloc>()
                      //     .state
                      //     .wallpaper
                      //     .wallpaperColor,
                      onChanged: (value) {
                        context.read<WallpaperBloc>().add(
                            WallpaperColorChangedEvent(
                                newWallpaperColor: value!));
                      },
                      underline: const SizedBox(),
                      items: QuoteStylingValues.colors.keys.map((Color value) {
                        return DropdownMenuItem<Color>(
                          value: value,
                          child: Row(
                            // mainAxisSize: MainAxisSize.min,
                            spacing: 10,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                color: value,
                              ),
                              Text(
                                QuoteStylingValues.colors[value]!,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
