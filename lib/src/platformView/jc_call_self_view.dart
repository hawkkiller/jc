import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jc/src/logic/jc_view_controller.dart';

class JcCallSelfView extends StatefulWidget {
  const JcCallSelfView({super.key});

  @override
  State<JcCallSelfView> createState() => _JcCallSelfViewState();
}

class _JcCallSelfViewState extends State<JcCallSelfView> {

  JcViewController? _controller;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          _controller?.setLayoutParams(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
          );
          if (Platform.isAndroid) {
            return AndroidView(
              viewType: 'JcCallSelfView',
              key: const GlobalObjectKey('JcCallSelfView'),
              layoutDirection: TextDirection.ltr,
              onPlatformViewCreated: (id) {
                _controller = JcViewController.create(viewId: id);
              },
            );
          }
          if (Platform.isIOS) {
            return UiKitView(
              viewType: 'JcCallSelfView',
              key: const GlobalObjectKey('JcCallSelfView'),
              onPlatformViewCreated: (id) {
                _controller = JcViewController.create(viewId: id);
              },
            );
          }
          throw UnsupportedError('Unsupported platform');
        },
      );
}
