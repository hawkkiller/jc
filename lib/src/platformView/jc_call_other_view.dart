import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jc/src/logic/jc_view_controller.dart';

class JCCallOtherView extends StatefulWidget {
  const JCCallOtherView({super.key});

  @override
  State<JCCallOtherView> createState() => _JCCallOtherViewState();
}

class _JCCallOtherViewState extends State<JCCallOtherView> {
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
              viewType: 'JcCallOtherView',
              layoutDirection: TextDirection.ltr,
              onPlatformViewCreated: (id) {
                _controller = JcViewController.create(viewId: id);
                _controller?.setLayoutParams(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                );
              },
            );
          }
          if (Platform.isIOS) {
            return UiKitView(
              viewType: 'JcCallOtherView',
              layoutDirection: TextDirection.ltr,
              onPlatformViewCreated: (id) {
                _controller = JcViewController.create(viewId: id);
                _controller?.setLayoutParams(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                );
              },
            );
          }
          throw UnsupportedError('Unsupported platform');
        },
      );
}
