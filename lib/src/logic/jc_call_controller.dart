import 'package:flutter/services.dart';
import 'package:jc/src/common/jc_controller.dart';
import 'package:jc/src/exception/jc_exception.dart';
import 'package:jc/src/generated/messages.g.dart';
import 'package:jc/src/logic/jc_call_state_channel.dart';
import 'package:jc/src/model/member.dart';
import 'package:meta/meta.dart';

/// The base implementation of [CallController] for calls.
base class JcCallController implements CallController {
  JcCallController._({
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

  /// Creates a new [JcCallController]. Initiates a call to [userID].
  /// 
  /// [userID] is the user ID to call.
  /// 
  /// [video] is whether the call should be a video call.
  /// 
  /// [jcCallApi] is the API to use for the call. This is only used for testing.
  /// 
  /// Throws a [JcException] if the call could not be initiated.
  static Future<JcCallController> create({
    required String userID,
    required bool video,
    @visibleForTesting JcCallApi? jcCallApi,
  }) async {
    try {
      final api = jcCallApi ?? JcCallApi();
      final initiateCall = await api.call(userID, video);
      if (!initiateCall) {
        throw PlatformException(code: 'initiateCallFailed');
      }
    } on PlatformException catch (e, stackTrace) {
      Error.throwWithStackTrace(JcPlatformException(e), stackTrace);
    }
    return JcCallController._();
  }
}
