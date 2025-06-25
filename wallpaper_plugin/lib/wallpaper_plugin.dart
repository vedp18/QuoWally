import 'package:flutter/services.dart';

class WallpaperPlugin {
  static const MethodChannel _channel = MethodChannel('wallpaper_channel');

  /// Optionally get Android platform version
  static Future<String?> getPlatformVersion() async {
    final version = await _channel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  /// Call this to schedule native wallpaper worker (in Kotlin)
  static Future<void> startWallpaperWorker({
    required String filePath,
    required int which,
  }) async {
    await _channel.invokeMethod('startNativeWallpaperWorker', {
      'filePath': filePath,
      'which': which,
    });
  }
}
