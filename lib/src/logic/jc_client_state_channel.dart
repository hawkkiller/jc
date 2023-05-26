import 'package:flutter/services.dart';
import 'package:jc/src/model/client_state.dart';
import 'package:stream_transform/stream_transform.dart';

abstract class JcClientStateChannel {
  Stream<ClientState> get clientStateStream;
}

class JcClientStateChannelImpl implements JcClientStateChannel {
  JcClientStateChannelImpl() {
    _eventChannel = const EventChannel('lazebny.io.jc/client_state_event_channel');
    clientStateStream = _eventChannel
        .receiveBroadcastStream()
        .whereType<String>()
        .map(ClientState.fromString);
  }

  late final EventChannel _eventChannel;

  @override
  late final Stream<ClientState> clientStateStream;
}
