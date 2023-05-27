import 'package:jc/jc.dart';
import 'package:jc/src/generated/messages.g.dart';
import 'package:jc/src/logic/jc_client_state_channel.dart';
import 'package:jc/src/model/client_state.dart';
import 'package:meta/meta.dart';

/// The shared platform implementation of [JcPlatform].
class SharedPlatform extends JcPlatform {
  SharedPlatform({
    @visibleForTesting JcClientStateChannel? clientStateChannel,
    @visibleForTesting JcApi? jcApi,
  })  : _jcApi = jcApi ?? JcApi(),
        _clientStateChannel = clientStateChannel ?? JcClientStateChannelBase();

  final JcApi _jcApi;
  final JcClientStateChannel _clientStateChannel;

  @override
  Future<bool> login(String appAccountNumber, String name) =>
      _jcApi.login(appAccountNumber, name);

  @override
  Future<bool> call(
    String userID, {
    bool video = true,
  }) =>
      _jcApi.call(userID, video);

  @override
  Future<bool> joinConference(String conferenceID, String password) =>
      _jcApi.joinConference(conferenceID, password);

  @override
  Stream<ClientState> get clientStateStream => _clientStateChannel.clientStateStream;
}
