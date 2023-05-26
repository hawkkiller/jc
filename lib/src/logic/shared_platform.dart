import 'package:flutter/foundation.dart';
import 'package:jc/jc.dart';
import 'package:jc/src/generated/messages.g.dart';
import 'package:jc/src/logic/jc_client_state_channel.dart';
import 'package:jc/src/model/client_state.dart';

/// The shared platform implementation of [JcPlatform].
class SharedPlatform extends JcPlatform {
  SharedPlatform({
    @visibleForTesting JcClientStateChannel? clientStateChannel,
    @visibleForTesting JcNativeApi? nativeApi,
  })  : _nativeApi = nativeApi ?? JcNativeApi(),
        _clientStateChannel = clientStateChannel ?? JcClientStateChannelImpl();

  final JcNativeApi _nativeApi;
  final JcClientStateChannel _clientStateChannel;

  @override
  Future<bool> login(String appAccountNumber, String name) =>
      _nativeApi.login(appAccountNumber, name);

  @override
  Future<bool> call(
    String userID, {
    bool video = true,
  }) =>
      _nativeApi.call(userID, video);

  @override
  Future<bool> joinConference(String conferenceID, String password) =>
      _nativeApi.joinConference(conferenceID, password);

  @override
  Stream<ClientState> get clientStateStream => _clientStateChannel.clientStateStream;
}
