import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JCConferenceView extends StatelessWidget {
  const JCConferenceView({required this.uid, super.key});

  final String uid;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return AndroidView(
        viewType: 'JcConferenceView',
        layoutDirection: TextDirection.ltr,
        creationParamsCodec: const StandardMessageCodec(),
        creationParams: <String, Object?>{
          'uid': uid,
        },
      );
    }
    if (Platform.isIOS) {
      return const UiKitView(
        viewType: 'JcConferenceView',
      );
    }
    throw UnsupportedError('Unsupported platform');
  }
}
