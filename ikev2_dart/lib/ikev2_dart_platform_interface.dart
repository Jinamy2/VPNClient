import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ikev2_dart_method_channel.dart';

abstract class Ikev2DartPlatform extends PlatformInterface {
  /// Constructs a Ikev2DartPlatform.
  Ikev2DartPlatform() : super(token: _token);

  static final Object _token = Object();

  static Ikev2DartPlatform _instance = MethodChannelIkev2Dart();

  /// The default instance of [Ikev2DartPlatform] to use.
  ///
  /// Defaults to [MethodChannelIkev2Dart].
  static Ikev2DartPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [Ikev2DartPlatform] when
  /// they register themselves.
  static set instance(Ikev2DartPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
