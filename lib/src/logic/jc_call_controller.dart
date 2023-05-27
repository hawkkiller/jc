import 'package:jc/src/common/jc_controller.dart';
import 'package:jc/src/generated/messages.g.dart';
import 'package:jc/src/logic/jc_call_state_channel.dart';
import 'package:jc/src/model/member.dart';
import 'package:meta/meta.dart';

base class JcCallController implements CallController {
  JcCallController({
    @visibleForTesting JcCallControllerApi? jcCallControllerApi,
    @visibleForTesting JcCallStateChannel? jcCallStateChannel,
  })  : _jcCallControllerApi = jcCallControllerApi ?? JcCallControllerApi(),
        _jcCallStateChannel = jcCallStateChannel ?? JcCallStateChannelBase();

  final JcCallControllerApi _jcCallControllerApi;
  final JcCallStateChannel _jcCallStateChannel;

  @override
  Future<void> enableCamera({required bool value}) => _jcCallControllerApi.enableCamera(value);

  @override
  Future<void> enableMicrophone({required bool value}) =>
      _jcCallControllerApi.enableMicrophone(value);

  @override
  Future<void> enableSpeaker({required bool value}) => _jcCallControllerApi.enableSpeaker(value);

  @override
  Stream<Member> get otherMember => _jcCallStateChannel.otherMember;

  @override
  Stream<SelfMember> get selfMember => _jcCallStateChannel.selfMember;

  @override
  Future<void> switchCamera() => _jcCallControllerApi.switchCamera();

  @override
  Future<void> terminate() => _jcCallControllerApi.terminate();
}
