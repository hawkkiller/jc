import 'package:flutter/services.dart';
import 'package:jc/src/common/view_controller.dart';

base class JcViewController implements ViewController {
  JcViewController.create({
    required int viewId,
  }) {
    _channel = MethodChannel('lazebny.io.jc/JcViewController/$viewId');
  }

  late final MethodChannel _channel;

  @override
  Future<void> setLayoutParams({
    required double width,
    required double height,
  }) =>
      _channel.invokeMethod('setLayoutParams', {
        'width': width,
        'height': height,
      });
}
