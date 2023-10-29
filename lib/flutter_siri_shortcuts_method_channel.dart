import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_siri_shortcuts_platform_interface.dart';

/// An implementation of [FlutterSiriShortcutsPlatform] that uses method channels.
class MethodChannelFlutterSiriShortcuts extends FlutterSiriShortcutsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_siri_shortcuts');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
