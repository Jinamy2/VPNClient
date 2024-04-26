// ignore_for_file: constant_identifier_names

enum FlutterVpnState {
  connected('VPN подключен', 2),
  disconnected('VPN отключен', 0),
  connecting('Подключение...', 1),
  disconnecting('Отключение...', 3),
  error('Попробуйте снова', 4);

  const FlutterVpnState(this.description, this.rawValue);

  factory FlutterVpnState.fromRawValue(int rawValue) =>
      _index[rawValue] ?? FlutterVpnState.error;

  factory FlutterVpnState.fromString(String value) => switch (value) {
        'Active' => FlutterVpnState.connected,
        'Disable' => FlutterVpnState.disconnected,
        'Connecting' => FlutterVpnState.connecting,
        'Disconnecting' => FlutterVpnState.disconnecting,
        'Error' => FlutterVpnState.error,
        _ => FlutterVpnState.error
      };

  static Map<int, FlutterVpnState> _index = (() => {
        FlutterVpnState.connected.rawValue: FlutterVpnState.connected,
        FlutterVpnState.connecting.rawValue: FlutterVpnState.connecting,
        FlutterVpnState.disconnected.rawValue: FlutterVpnState.disconnected,
        FlutterVpnState.disconnecting.rawValue: FlutterVpnState.disconnecting,
        FlutterVpnState.error.rawValue: FlutterVpnState.error,
      }).call();

  final String description;
  final int rawValue;
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
