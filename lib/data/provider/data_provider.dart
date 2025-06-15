import 'dart:convert';
import 'package:http/http.dart' as http;

class DataProvider {
  static Future<void> fetchSlokas() async {
    final url =
        'https://gist.githubusercontent.com/vedp18/6dc2c6d50120310097f8a8e555c266f2/raw/7c17b17678e43e61f0a8f70080f901f6d864eed3/bhagavad_gita.json';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> slokas = jsonDecode(response.body);
        // Use slokas in your app
        print(slokas[0]); // Example
      } else {
        print('Failed to load slokas: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching slokas: $e');
    }
  }
}
