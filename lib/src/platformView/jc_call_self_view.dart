import 'dart:io';

import 'package:flutter/material.dart';

class JCCallSelfView extends StatelessWidget {
  const JCCallSelfView({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return const AndroidView(
        viewType: 'JcCallSelfView',
        layoutDirection: TextDirection.ltr,
      );
    }
    if (Platform.isIOS) {
      return const UiKitView(
        viewType: 'JcCallSelfView',
      );
    }
    throw UnsupportedError('Unsupported platform');
  }
}
