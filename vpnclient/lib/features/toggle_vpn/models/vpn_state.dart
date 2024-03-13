enum VpnState {
  active('VPN подключен'),
  disable('VPN отключен'),
  connecting('Подключение...'),
  disconnecting('Отключение'),
  noConfigFile('Примите конфигурацию VPN'),
  unknown('Попробуйте снова');

  const VpnState(this.description);

  factory VpnState.fromString(String value) => switch (value) {
        'Active' => VpnState.active,
        'Disable' => VpnState.disable,
        'Connecting' => VpnState.connecting,
        'Disconnecting' => VpnState.disconnecting,
        'NoConfigFile' => VpnState.noConfigFile,
        _ => VpnState.unknown
      };

  final String description;
}
