import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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
