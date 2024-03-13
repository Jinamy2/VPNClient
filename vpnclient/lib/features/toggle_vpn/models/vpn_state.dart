enum VpnState {
  active,
  disable,
  connecting,
  disconnecting,
  noConfigFile,
  unknown;

  factory VpnState.fromString(String value) => switch (value) {
        'Active' => VpnState.active,
        'Disable' => VpnState.disable,
        'Connecting' => VpnState.connecting,
        'Disconnecting' => VpnState.disconnecting,
        'NoConfigFile' => VpnState.noConfigFile,
        _ => VpnState.unknown
      };
}
