import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/generated/messages.g.dart',
  kotlinOut: 'android/src/main/kotlin/lazebny/io/jc/pigeon/Messages.g.kt',
  swiftOut: 'ios/Classes/Messages.g.swift',
))
@HostApi()
abstract class ExampleHostApi {
  String getHostLanguage();
}
