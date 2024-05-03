import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ikev2_dart/models/vpn_state.dart';

import 'ikev2_dart_platform_interface.dart';

/// An implementation of [Ikev2DartPlatform] that uses method channels.
class MethodChannelIkev2Dart extends Ikev2DartPlatform {
  MethodChannelIkev2Dart() {
    listenToVpnState();
    methodChannel.setMethodCallHandler((call) {
      if (call.method == "updateVpnState" && call.arguments is int) {
        final state = FlutterVpnState.fromRawValue(call.arguments);
        handler?.call(state);
      }
      return Future.value();
    });
  }

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ikev2_dart');

  /// The method channel used to receive state change event.
  @visibleForTesting
  final eventChannel = const EventChannel('ikev2_dart_states');

  /// The method channel used to receive traffic reports.
  @visibleForTesting
  final eventTrafficChannel = const EventChannel('ikev2_dart_traffic');

  Function(FlutterVpnState p1)? handler;

  /// Receive state change from VPN service.
  ///
  /// Can only be listened once. If have more than one subscription, only the
  /// last subscription can receive events.

  void listenToVpnState() {
    eventChannel.receiveBroadcastStream().listen((event) {
      final state = FlutterVpnState.fromRawValue(event);
      handler?.call(state);
    });
  }

  @override
  Stream<Map> get onTrafficReport =>
      eventTrafficChannel.receiveBroadcastStream().map((e) => e);

  /// Get current state.
  @override
  Future<FlutterVpnState> get currentState async {
    final state = await methodChannel.invokeMethod<int>('getCurrentState');
    assert(state != null, 'Received a null state from `getCurrentState` call.');
    return FlutterVpnState.values[state!];
  }

  /// Get current error state from `VpnStateService`. (Android only)
  /// When [FlutterVpnState.error] is received, details of error can be
  /// inspected by [CharonErrorState]. Returns [null] on non-android platform.
  @override
  Future<CharonErrorState?> get charonErrorState async {
    if (!Platform.isAndroid) return null;
    var state = await methodChannel.invokeMethod<int>('getCharonErrorState');
    assert(
      state != null,
      'Received a null state from `getCharonErrorState` call.',
    );
    return CharonErrorState.values[state!];
  }

  /// Prepare for vpn connection. (Android only)
  ///
  /// For first connection it will show a dialog to ask for permission.
  /// When your connection was interrupted by another VPN connection,
  /// you should prepare again before reconnect.
  @override
  Future<bool> prepare() async {
    if (!Platform.isAndroid) return true;
    return (await methodChannel.invokeMethod<bool>('prepare'))!;
  }

  @override
  Future<void> setRuleType(String rule, String type) async {
    return methodChannel.invokeMethod<void>('setRuleType', {
      'rule': rule,
      'type': type,
    });
  }

  @override
  Future<void> deleteRuleType(String rule, String type) async {
    return methodChannel.invokeMethod<void>('deleteRuleType', {
      'rule': rule,
      'type': type,
    });
  }

  @override
  Future<void> saveFile(String path, String file) async {
    return methodChannel.invokeMethod<void>('saveFile', {
      'path': path,
      'file': file,
    });
  }

  /// Check if vpn connection has been prepared. (Android only)
  @override
  Future<bool> get prepared async {
    if (!Platform.isAndroid) return true;
    return (await methodChannel.invokeMethod<bool>('prepared'))!;
  }

  /// Disconnect and stop VPN service.
  @override
  Future<void> disconnect() async {
    await methodChannel.invokeMethod('disconnect');
  }

  /// Connect to VPN. (IKEv2-EAP)
  ///
  /// This will create a background VPN service.
  /// MTU is only available on android.
  @override
  Future<void> connectIkev2EAP({
    required String server,
    required String username,
    required String password,
    String? name,
    int? mtu,
    int? port,
  }) async =>
      await methodChannel.invokeMethod('connect', {
        'Type': 'IKEv2',
        'Server': server,
        'Username': username,
        'Password': password,
        'Secret': '',
        'Name': name ?? server,
        if (mtu != null) 'mtu': mtu,
        if (port != null) 'port': port,
      });

  /// Connect to VPN. (IPSec)
  ///
  /// This will create a background VPN service.
  /// Android implementation is not available.
  @override
  Future<void> connectIPSec({
    required String server,
    required String username,
    required String password,
    required String secret,
    String? name,
    int? mtu,
    int? port,
  }) async =>
      await methodChannel.invokeMethod('connect', {
        'Type': 'IPSec',
        'Server': server,
        'Username': username,
        'Password': password,
        'Secret': secret,
        'Name': name ?? server,
        if (mtu != null) 'mtu': mtu,
        if (port != null) 'port': port,
      });

  @override
  void setVpnStateChangeHandler(Function(FlutterVpnState p1) handler) {
    this.handler = handler;
  }
}
