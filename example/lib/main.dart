import 'dart:async';
import 'dart:developer';

import 'package:example/src/feature/feed/widget/feed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jc/jc.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runZonedGuarded(
    () => runApp(const App()),
    (error, stack) {
      log('Error: $error\nStack: $stack');
    },
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Future<void> _initialize() async {
    await dotenv.load(fileName: '.env');
    final initialized = await JcSdk.instance.initialize(dotenv.get('JC_APP_KEY'));
    log('JcSdk initialized: $initialized');
    final login = await JcSdk.instance.login(
      appAccountNumber: 'lazebny.io',
      name: 'Michael Lazebny',
    );
    log('JcSdk login: $login');
    final req = await Permission.camera.request();
    log('Permission.camera.request: $req');
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jc Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FeedScreen(),
    );
  }
}
