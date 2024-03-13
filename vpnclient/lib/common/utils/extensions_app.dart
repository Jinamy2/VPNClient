import 'package:flutter/material.dart';
import 'package:vpnclient/features/toggle_vpn/models/vpn_state.dart';

extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension StatusLocale on VpnState {
  String getStatusText(BuildContext context) => switch (this) {
        VpnState.active => 'VPN подключен',
        VpnState.disable => 'VPN отключен',
        VpnState.connecting => 'Подключение...',
        VpnState.disconnecting => 'Отключение',
        VpnState.noConfigFile => 'Примите конфигурацию VPN',
        VpnState.unknown => 'Попробуйте снова',
      };
}
