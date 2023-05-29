import 'dart:io';

import 'package:flutter/material.dart';

class JCCallOtherView extends StatelessWidget {
  const JCCallOtherView({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return const AndroidView(
        viewType: 'JcCallOtherView',
        layoutDirection: TextDirection.ltr,
      );
    }
    if (Platform.isIOS) {
      return const UiKitView(
        viewType: 'JcCallOtherView',
      );
    }
    throw UnsupportedError('Unsupported platform');
  }
}
