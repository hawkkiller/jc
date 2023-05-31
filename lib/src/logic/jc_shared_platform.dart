import 'dart:async';

import 'package:jc/jc.dart';
import 'package:jc/src/generated/messages.g.dart';
import 'package:jc/src/logic/jc_client_state_channel.dart';
import 'package:jc/src/model/client_state.dart';
import 'package:meta/meta.dart';

/// The shared platform implementation of [JcPlatform].
class JcSharedPlatform extends JcPlatform {
  JcSharedPlatform({
    @visibleForTesting JcClientStateChannel? clientStateChannel,
    @visibleForTesting JcApi? jcApi,
  })  : _jcApi = jcApi ?? JcApi(),
        _clientStateChannel = clientStateChannel ?? JcClientStateChannelBase();

  final JcApi _jcApi;
  final JcClientStateChannel _clientStateChannel;

  @override
  Future<bool> login(String appAccountNumber, String name) async {
    final started = await _jcApi.login(appAccountNumber, name);
    if (!started) {
      return false;
    }
    final completer = Completer<bool>();
    final sub = _clientStateChannel.clientStateStream.listen((event) {
      if (event == ClientState.logined) {
        completer.complete(true);
      } else if (event == ClientState.notInit) {
        completer.complete(false);
      }
    });
    final res = await completer.future.timeout(const Duration(seconds: 10), onTimeout: () => false);
    await sub.cancel();
    return res;
  }

  @override
  Stream<ClientState> get clientStateStream => _clientStateChannel.clientStateStream;

  @override
  Future<bool> initialize(String appKey) => _jcApi.initialize(appKey);
}
