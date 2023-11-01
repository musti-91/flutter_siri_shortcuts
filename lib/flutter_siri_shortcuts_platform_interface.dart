import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_siri_shortcuts.dart';

/*
const opts1: ShortcutOptions = {
  activityType: 'com.github.gustash.SiriShortcutsModuleExample.sayHello',
  title: 'Say Hi',
  userInfo: {
    foo: 1,
    bar: 'baz',
    baz: 34.5,
  },
  requiredUserInfoKeys: ['foo', 'bar', 'baz'],
  keywords: ['kek', 'foo', 'bar'],
  persistentIdentifier:
    'com.github.gustash.SiriShortcutsModuleExample.sayHello',
  isEligibleForSearch: true,
  isEligibleForPrediction: true,
  suggestedInvocationPhrase: 'Say something',
  needsSave: true,
};
*/

abstract class FlutterSiriShortcutsPlatform extends PlatformInterface {
  FlutterSiriShortcutsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterSiriShortcutsPlatform _instance = FlutterSiriShortcuts();

  static FlutterSiriShortcutsPlatform get instance => _instance;

  static set instance(FlutterSiriShortcutsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool?> presentShortcut({FlutterSiriShortcutArgs? options}) async {
    throw UnimplementedError('presentShortcut() has not been implemented.');
  }

  Future<bool?> donateShortcut({FlutterSiriShortcutArgs? options}) async {
    throw UnimplementedError('donateShortcut() has not been implemented.');
  }

  Future<bool?> clearShortcuts() {
    throw UnimplementedError('clearShortcuts() has not been implemented.');
  }
}
