import 'dart:io';

import 'package:flutter/foundation.dart' show debugPrint;

class CustomLogger {
  static Future<void> logToFile(String message) async {
    // print("look i m CustomLogger");
    try {
      final path = '/data/user/0/com.vpx.quowally/app_flutter/log.txt';
      final file = File(path);
      final timestamp = DateTime.now().toLocal().toString();

      debugPrint(message);
      await file.writeAsString("[$timestamp] $message\n",
          mode: FileMode.append);
    } catch (e) {
      // optional fallback
      debugPrint("Logging failed: $e");
    }
  }
}
