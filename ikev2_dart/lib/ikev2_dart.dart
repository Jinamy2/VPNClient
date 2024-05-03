import 'package:ikev2_dart/models/vpn_state.dart';

import 'ikev2_dart_platform_interface.dart';

class Ikev2Dart {
  // Receive state change from VPN service.
  ///
  /// Can only be listened once. If have more than one subscription, only the
  /// last subscription can receive events.
  static Stream<FlutterVpnState> get onStateChanged =>
      Ikev2DartPlatform.instance.onStateChanged;
  static Stream<FlutterVpnState> get getTrafficReport =>
      Ikev2DartPlatform.instance.onStateChanged;

  /// Get current state.
  static Future<FlutterVpnState> get currentState =>
      Ikev2DartPlatform.instance.currentState;

  /// Get current error state from `VpnStateService`. (Android only)
  /// When [FlutterVpnState.error] is received, details of error can be
  /// inspected by [CharonErrorState]. Returns [null] on non-android platform.
  static Future<CharonErrorState?> get charonErrorState =>
      Ikev2DartPlatform.instance.charonErrorState;

  /// Prepare for vpn connection. (Android only)
  ///
  /// For first connection it will show a dialog to ask for permission.
  /// When your connection was interrupted by another VPN connection,
  /// you should prepare again before reconnect.
  static Future<bool> prepare() => Ikev2DartPlatform.instance.prepare();

  /// Check if vpn connection has been prepared. (Android only)
  static Future<bool> get prepared => Ikev2DartPlatform.instance.prepared;

  /// Disconnect and stop VPN service.
  static Future<void> disconnect() => Ikev2DartPlatform.instance.disconnect();

  static Future<void> setRuleType(String rule, String type) =>
      Ikev2DartPlatform.instance.setRuleType(rule, type);

  static Future<void> deleteRuleType(String rule, String type) =>
      Ikev2DartPlatform.instance.deleteRuleType(rule, type);

  static Future<void> saveFile(String path, String file) =>
      Ikev2DartPlatform.instance.saveFile(path, file);

  /// Connect to VPN. (IKEv2-EAP)
  ///
  /// This will create a background VPN service.
  /// MTU is only available on android.
  static Future<void> connectIkev2EAP({
    required String server,
    required String username,
    required String password,
    String? name,
    int? mtu,
    int? port,
  }) =>
      Ikev2DartPlatform.instance.connectIkev2EAP(
        server: server,
        username: username,
        password: password,
        name: name,
        mtu: mtu,
        port: port,
      );

  /// Connect to VPN. (IPSec)
  ///
  /// This will create a background VPN service.
  /// Android implementation is not available.
  static Future<void> connectIPSec({
    required String server,
    required String username,
    required String password,
    required String secret,
    String? name,
    int? mtu,
    int? port,
  }) async =>
      Ikev2DartPlatform.instance.connectIPSec(
        server: server,
        username: username,
        password: password,
        secret: secret,
        name: name,
        mtu: mtu,
        port: port,
      );
}
