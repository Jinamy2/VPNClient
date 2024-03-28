// ignore_for_file: constant_identifier_names

enum FlutterVpnState {
  connected('VPN подключен'),
  disconnected('VPN отключен'),
  connecting('Подключение...'),
  disconnecting('Отключение'),
  error('Попробуйте снова');

  const FlutterVpnState(this.description);

  factory FlutterVpnState.fromString(String value) => switch (value) {
        'Active' => FlutterVpnState.connected,
        'Disable' => FlutterVpnState.disconnected,
        'Connecting' => FlutterVpnState.connecting,
        'Disconnecting' => FlutterVpnState.disconnecting,
        'Error' => FlutterVpnState.error,
        _ => FlutterVpnState.error
      };

  final String description;
}

enum CharonErrorState {
  NO_ERROR,
  AUTH_FAILED,
  PEER_AUTH_FAILED,
  LOOKUP_FAILED,
  UNREACHABLE,
  GENERIC_ERROR,
  PASSWORD_MISSING,
  CERTIFICATE_UNAVAILABLE,
}
