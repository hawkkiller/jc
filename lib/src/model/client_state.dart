enum ClientState {
  notInit,
  idle,
  logining,
  logined,
  logouting;

  static ClientState fromInt(int value) => switch (value) {
        0 => ClientState.notInit,
        1 => ClientState.idle,
        2 => ClientState.logining,
        3 => ClientState.logined,
        4 => ClientState.logouting,
        _ => throw Exception('Unknown ClientState value: $value'),
      };
}
