import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'flutter_siri_shortcuts_platform_interface.dart';

class FlutterSiriShortcutArgs {
  String title = '';
  String activityType = 'Example';
  String suggestedInvocationPhrase = 'Say Something';
  String? persistentIdentifier = '';
  List<String>? requiredUserInfoKeys = [];
  List<String>? keywords = [];
  Map<String, String>? userInfo = {};
  bool? isEligibleForSearch = true;
  bool? isEligibleForPrediction = true;
  bool? needsSave = true;

  FlutterSiriShortcutArgs({
    required this.title,
    required this.activityType,
    required this.suggestedInvocationPhrase,
    this.persistentIdentifier,
    this.isEligibleForPrediction,
    this.isEligibleForSearch,
    this.keywords,
    this.needsSave,
    this.requiredUserInfoKeys,
    this.userInfo,
  });
}

class FlutterSiriShortcuts extends FlutterSiriShortcutsPlatform {
  FlutterSiriShortcuts({this.initOptions});

  FlutterSiriShortcutArgs? initOptions;

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_siri_shortcuts');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> presentShortcut({FlutterSiriShortcutArgs? options}) async {
    return FlutterSiriShortcutsPlatform.instance
        .presentShortcut(options: options ?? initOptions!);
  }

  @override
  Future<bool?> donateShortcut({FlutterSiriShortcutArgs? options}) async {
    return FlutterSiriShortcutsPlatform.instance
        .donateShortcut(options: options ?? initOptions!);
  }

  @override
  Future<bool?> clearShortcuts() {
    return FlutterSiriShortcutsPlatform.instance.clearShortcuts();
  }
}

// ignore: must_be_immutable
class AddToSiriButton extends StatelessWidget {
  String title = "default";
  String url = "default";
  String id = "default";
  double? height = 20.0;

  AddToSiriButton({
    super.key,
    required this.title,
    required this.id,
    required this.url,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    const String viewType = 'AddToSiriButton';
    Map<String, dynamic> creationParams = <String, dynamic>{
      'title': title,
      'id': id,
      'url': url
    };

    return Container(
      height: height ?? 20.0,
      child: UiKitView(
        viewType: viewType,
        creationParams: creationParams,
        layoutDirection: TextDirection.ltr,
        creationParamsCodec: const StandardMessageCodec(),
      ),
    );
  }
}
