
import 'flutter_siri_shortcuts_platform_interface.dart';

class FlutterSiriShortcuts {
  Future<String?> getPlatformVersion() {
    return FlutterSiriShortcutsPlatform.instance.getPlatformVersion();
  }
}
