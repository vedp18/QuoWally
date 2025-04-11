import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuoteSettingsScreen extends StatefulWidget {
  const QuoteSettingsScreen({super.key});

  @override
  State<QuoteSettingsScreen> createState() => _QuoteSettingsScreenState();
}

class _QuoteSettingsScreenState extends State<QuoteSettingsScreen> {
  String textColor = 'white';
  String quoteSize = 'small';
  String authorSize = 'small';
  String quoteAlign = 'left';
  String authorAlign = 'right';
  String quoteStyle = 'normal';
  String authorStyle = 'italic';
  String quoteFont = 'New Rocker';
  String authorFont = 'Almendra';

  final List<String> sizes = ['small', 'normal', 'large'];
  final List<String> alignments = ['left', 'center', 'right'];
  final List<String> styles = ['normal', 'bold', 'italic', 'bold italic'];
  final List<String> colors = ['white', 'black', 'grey'];
  final List<String> fonts = [
    'New Rocker',
    'Almendra',
    'Roboto',
    'Lobster',
    'Pacifico'
  ];

  TextStyle getTextStyle(String font, String style, String size, String color) {
    double fontSize = size == 'small'
        ? 14
        : size == 'normal'
            ? 18
            : 22;

    FontWeight fontWeight =
        style.contains('bold') ? FontWeight.bold : FontWeight.normal;
    FontStyle fontStyle =
        style.contains('italic') ? FontStyle.italic : FontStyle.normal;

    Color textColor = color == 'white'
        ? Colors.white
        : color == 'black'
            ? Colors.black
            : Colors.grey;

    return GoogleFonts.getFont(font,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        color: textColor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Quotes"),
        actions: const [
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: Text("RATE US"))),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: Text("SHARE"))),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle("Text Color"),
          _buildDropdown(
              colors, textColor, (val) => setState(() => textColor = val!)),
          _buildSectionTitle("Quote Text Size"),
          _buildDropdown(
              sizes, quoteSize, (val) => setState(() => quoteSize = val!)),
          _buildSectionTitle("Author Text Size"),
          _buildDropdown(
              sizes, authorSize, (val) => setState(() => authorSize = val!)),
          _buildSectionTitle("Quote Text Align"),
          _buildDropdown(alignments, quoteAlign,
              (val) => setState(() => quoteAlign = val!)),
          _buildSectionTitle("Author Text Align"),
          _buildDropdown(alignments, authorAlign,
              (val) => setState(() => authorAlign = val!)),
          _buildSectionTitle("Quote Text Style"),
          _buildDropdown(
              styles, quoteStyle, (val) => setState(() => quoteStyle = val!)),
          _buildSectionTitle("Author Text Style"),
          _buildDropdown(
              styles, authorStyle, (val) => setState(() => authorStyle = val!)),
          _buildSectionTitle("Quote Text Font"),
          _buildDropdown(
              fonts, quoteFont, (val) => setState(() => quoteFont = val!)),
          _buildSectionTitle("Author Text Font"),
          _buildDropdown(
              fonts, authorFont, (val) => setState(() => authorFont = val!)),
          const SizedBox(height: 16),
          _buildSectionTitle("Preview"),
          Container(
            color: Colors.grey[300],
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: _getAlignment(quoteAlign),
                  child: Text(
                    "Work hard, think harder. Else be ready to accept failure.",
                    style: getTextStyle(
                        quoteFont, quoteStyle, quoteSize, textColor),
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: _getAlignment(authorAlign),
                  child: Text(
                    "- A Hard Worker",
                    style: getTextStyle(
                        authorFont, authorStyle, authorSize, textColor),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Save logic goes here
            },
            child: const Text("APPLY"),
          )
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildDropdown(
      List<String> items, String value, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: value,
      items:
          items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
      decoration: const InputDecoration(border: OutlineInputBorder()),
    );
  }

  Alignment _getAlignment(String align) {
    switch (align) {
      case 'center':
        return Alignment.center;
      case 'right':
        return Alignment.centerRight;
      default:
        return Alignment.centerLeft;
    }
  }
}
