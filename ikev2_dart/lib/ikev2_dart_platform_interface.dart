import 'package:ikev2_dart/models/vpn_state.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ikev2_dart_method_channel.dart';

abstract class Ikev2DartPlatform extends PlatformInterface {
  /// Constructs a Ikev2DartPlatform.
  Ikev2DartPlatform() : super(token: _token);

  static final Object _token = Object();

  static final Ikev2DartPlatform _instance = MethodChannelIkev2Dart();

  static Ikev2DartPlatform get instance => _instance;

  Stream<FlutterVpnState> get onStateChanged => throw UnimplementedError();

  Stream<Map> get onTrafficReport => throw UnimplementedError();

  Future<FlutterVpnState> get currentState async => throw UnimplementedError();

  Future<CharonErrorState?> get charonErrorState async =>
      throw UnimplementedError();

  Future<bool> prepare() async => throw UnimplementedError();

  Future<bool> get prepared async => throw UnimplementedError();

  Future<void> disconnect() async => throw UnimplementedError();

  Future<void> connectIkev2EAP({
    required String server,
    required String username,
    required String password,
    String? name,
    int? mtu,
    int? port,
  }) async =>
      throw UnimplementedError();

  Future<void> connectIPSec({
    required String server,
    required String username,
    required String password,
    required String secret,
    String? name,
    int? mtu,
    int? port,
  }) async =>
      throw UnimplementedError();
}
