import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ikev2_dart_platform_interface.dart';

/// An implementation of [Ikev2DartPlatform] that uses method channels.
class MethodChannelIkev2Dart extends Ikev2DartPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ikev2_dart');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
