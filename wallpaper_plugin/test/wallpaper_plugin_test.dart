import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wallpaper_plugin/wallpaper_plugin.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const MethodChannel channel = MethodChannel('wallpaper_channel');

  final List<MethodCall> log = <MethodCall>[];

  late TestDefaultBinaryMessengerBinding binding;

  setUp(() {
    // This sets up a safe test environment for method channel mocking
    binding = TestDefaultBinaryMessengerBinding.instance;

    binding.defaultBinaryMessenger.setMockMethodCallHandler(channel, (
      methodCall,
    ) async {
      log.add(methodCall);

      if (methodCall.method == 'getPlatformVersion') {
        return 'Android 13';
      }

      if (methodCall.method == 'startNativeWallpaperWorker') {
        return 'Worker scheduled';
      }

      return null;
    });

    log.clear();
  });

  tearDown(() {
    binding.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion returns mocked Android version', () async {
    final version = await WallpaperPlugin.getPlatformVersion();
    expect(version, 'Android 13');
    expect(log.first.method, 'getPlatformVersion');
  });

  test('startWallpaperWorker sends correct method and arguments', () async {
    await WallpaperPlugin.startWallpaperWorker(
      filePath: '/fake/path/wallpaper.png',
      which: 2,
    );

    expect(log.first.method, 'startNativeWallpaperWorker');
    expect(log.first.arguments, {
      'filePath': '/fake/path/wallpaper.png',
      'which': 2,
    });
  });
}
