# flutter_siri_shortcuts

A Flutter plugin to use iOS shortcuts

|             | Android | iOS   | Linux | macOS | Web | Windows |
| ----------- | ------- | ----- | ----- | ----- | --- | ------- |
| **Support** | NO      | 11.0+ | NO    | Soon  | NO  | NO      |

## Usage

To use this plugin, add `flutter_siri_shortcuts` as a [dependency in your pubspec.yaml file](https://flutter.dev/platform-plugins/).

### Example

<?code-excerpt "example/main.dart (basic-example)"?>

```dart
import 'package:flutter/material.dart';
import 'package:flutter_siri_shortcuts/flutter_siri_shortcuts.dart';

Widget build(BuildContext context) {
    return Center(
              child: AddToSiriButton(
              title: 'something',
              id: 'test1',
              url: 'https://someurl.com',
            ),
        );
}
```

See the example app for more complex examples.

## Configuration

### Options

You only need to provide options related to the shortcut.

---

MIT License
