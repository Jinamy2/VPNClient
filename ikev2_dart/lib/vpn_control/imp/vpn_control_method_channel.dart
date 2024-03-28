import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ikev2_dart/models/vpn_state.dart';
import 'package:ikev2_dart/vpn_control/vpn_control.dart';

class MethodChanneVpnControl extends VpnControl {
  MethodChanneVpnControl() {
    methodChannel.setMethodCallHandler(
      (call) {
        switch (call.method) {
          case 'UPDATE_VPN_STATE_HANDLER':
            handleVPNStateUpdate(call);
            return Future.value();
          default:
            return Future.value();
        }
      },
    );
  }

  void Function(FlutterVpnState)? handler;

  @visibleForTesting
  final methodChannel = const MethodChannel('vpn_control');

  @override
  void handleVPNStateUpdate(MethodCall call) {
    final newState = call.arguments is String
        ? FlutterVpnState.fromString(call.arguments as String)
        : FlutterVpnState.error;

    handler?.call(newState);

    //print(newState);
  }

  @override
  void setVpnStateUpdateHandler(
      {required void Function(FlutterVpnState)? handler}) {
    this.handler = handler;
  }

  @override
  Future<FlutterVpnState> get vpnState =>
      methodChannel.invokeMethod<String>('get-vpn-state').then(
            (rawState) => rawState != null
                ? FlutterVpnState.fromString(rawState)
                : FlutterVpnState.error,
          );

  @override
  Future<void> startVPN() => methodChannel.invokeMethod<String>('start-vpn');

  @override
  Future<void> getPermissionVPN() =>
      methodChannel.invokeMethod('get-permission-vpn');

  @override
  Future<void> stopVPN() => methodChannel.invokeMethod('stop-vpn');
}
