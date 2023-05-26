enum ClientState {
  idle,
  logging,
  logined;

  static ClientState fromString(String value) => switch (value) {
        'idle' => ClientState.idle,
        'logging' => ClientState.logging,
        'logined' => ClientState.logined,
        _ => throw ArgumentError.value(
            value,
            'value',
            'Invalid value',
          )
      };
}
