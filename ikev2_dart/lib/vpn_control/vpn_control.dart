import 'package:flutter/services.dart';
import 'package:ikev2_dart/models/vpn_state.dart';
import 'package:ikev2_dart/vpn_control/imp/vpn_control_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class VpnControl extends PlatformInterface {
  VpnControl() : super(token: _token);
  static final Object _token = Object();

  static VpnControl _instance = MethodChanneVpnControl();

  static VpnControl get instance => _instance;

  static set instance(VpnControl instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  void handleVPNStateUpdate(MethodCall call) => throw UnimplementedError(
        'handleVPNStateUpdate() has not been implemented.',
      );

  void setVpnStateUpdateHandler(
          {required void Function(FlutterVpnState)? handler}) =>
      throw UnimplementedError(
        'setVpnStateUpdateHandler() has not been implemented.',
      );

  Future<FlutterVpnState> get vpnState =>
      throw UnimplementedError('platformVersion() has not been implemented.');

  Future<void> startVPN() =>
      throw UnimplementedError('platformVersion() has not been implemented.');

  Future<void> stopVPN() =>
      throw UnimplementedError('platformVersion() has not been implemented.');

  Future<void> getPermissionVPN() =>
      throw UnimplementedError('platformVersion() has not been implemented.');
}
