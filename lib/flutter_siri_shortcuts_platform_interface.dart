import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_siri_shortcuts_method_channel.dart';

abstract class FlutterSiriShortcutsPlatform extends PlatformInterface {
  /// Constructs a FlutterSiriShortcutsPlatform.
  FlutterSiriShortcutsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterSiriShortcutsPlatform _instance = MethodChannelFlutterSiriShortcuts();

  /// The default instance of [FlutterSiriShortcutsPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterSiriShortcuts].
  static FlutterSiriShortcutsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterSiriShortcutsPlatform] when
  /// they register themselves.
  static set instance(FlutterSiriShortcutsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
