import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_siri_shortcuts/flutter_siri_shortcuts.dart';
import 'package:flutter_siri_shortcuts/flutter_siri_shortcuts_platform_interface.dart';
import 'package:flutter_siri_shortcuts/flutter_siri_shortcuts_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterSiriShortcutsPlatform
    with MockPlatformInterfaceMixin
    implements FlutterSiriShortcutsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterSiriShortcutsPlatform initialPlatform = FlutterSiriShortcutsPlatform.instance;

  test('$MethodChannelFlutterSiriShortcuts is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterSiriShortcuts>());
  });

  test('getPlatformVersion', () async {
    FlutterSiriShortcuts flutterSiriShortcutsPlugin = FlutterSiriShortcuts();
    MockFlutterSiriShortcutsPlatform fakePlatform = MockFlutterSiriShortcutsPlatform();
    FlutterSiriShortcutsPlatform.instance = fakePlatform;

    expect(await flutterSiriShortcutsPlugin.getPlatformVersion(), '42');
  });
}
