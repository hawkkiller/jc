// import 'package:flutter_test/flutter_test.dart';
// import 'package:jc/jc.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockJcPlatform with MockPlatformInterfaceMixin implements JcPlatform {
//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final JcPlatform initialPlatform = JcPlatform.instance;

//   test('$MethodChannelJc is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelJc>());
//   });

//   test('getPlatformVersion', () async {
//     JcSdk jcPlugin = JcSdk();
//     MockJcPlatform fakePlatform = MockJcPlatform();
//     JcPlatform.instance = fakePlatform;

//     expect(await jcPlugin.getPlatformVersion(), '42');
//   });
// }
