import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jc/src/logic/jc_view_controller.dart';

class JCConferenceView extends StatefulWidget {
  const JCConferenceView({required this.uid, super.key});

  final String uid;

  @override
  State<JCConferenceView> createState() => _JCConferenceViewState();
}

class _JCConferenceViewState extends State<JCConferenceView> {
  JcViewController? _controller;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          _controller?.setLayoutParams(
            width: 100,
            height: 200,
          );
          if (Platform.isAndroid) {
            return AndroidView(
              viewType: 'JcConferenceView',
              layoutDirection: TextDirection.ltr,
              creationParamsCodec: const StandardMessageCodec(),
              creationParams: <String, Object?>{
                'uid': widget.uid,
              },
              onPlatformViewCreated: (id) {
                _controller = JcViewController.create(viewId: id);
              },
            );
          }
          if (Platform.isIOS) {
            return UiKitView(
              viewType: 'JcConferenceView',
              key: GlobalObjectKey(widget.uid),
              creationParamsCodec: const StandardMessageCodec(),
              creationParams: <String, Object?>{
                'uid': widget.uid,
              },
              onPlatformViewCreated: (id) {
                _controller = JcViewController.create(viewId: id);
              },
            );
          }
          throw UnsupportedError('Unsupported platform');
        },
      );
}
