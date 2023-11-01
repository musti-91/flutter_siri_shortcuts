import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_siri_shortcuts/flutter_siri_shortcuts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FlutterSiriShortcuts _flutterSiriShortcutsPlugin;

  @override
  void initState() {
    super.initState();
    final options = FlutterSiriShortcutArgs(
      title: 'test',
      activityType: 'any activity',
      suggestedInvocationPhrase: 'Hel',
    );
    _flutterSiriShortcutsPlugin = FlutterSiriShortcuts(initOptions: options);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Siri shortcuts example'),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Center(
                child: AddToSiriButton(
                  title: 'something',
                  id: 'test1',
                  url: 'https://someurl.com',
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    _flutterSiriShortcutsPlugin.presentShortcut();
                  } on PlatformException {
                    print('');
                  }
                },
                child: const Text('present shortcuts example'),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    _flutterSiriShortcutsPlugin.donateShortcut();
                  } on PlatformException {
                    print('');
                  }
                },
                child: const Text('donate shortcuts example'),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  try {
                    _flutterSiriShortcutsPlugin.clearShortcuts();
                  } on PlatformException {
                    print('');
                  }
                },
                child: const Text('clear all shortcuts example'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
