
import 'ikev2_dart_platform_interface.dart';

class Ikev2Dart {
  Future<String?> getPlatformVersion() {
    return Ikev2DartPlatform.instance.getPlatformVersion();
  }
}
