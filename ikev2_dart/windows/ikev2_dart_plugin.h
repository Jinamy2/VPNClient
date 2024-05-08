#ifndef FLUTTER_PLUGIN_IKEV2_DART_PLUGIN_H_
#define FLUTTER_PLUGIN_IKEV2_DART_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace ikev2_dart {

class Ikev2DartPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  Ikev2DartPlugin();

  virtual ~Ikev2DartPlugin();

  // Disallow copy and assign.
  Ikev2DartPlugin(const Ikev2DartPlugin&) = delete;
  Ikev2DartPlugin& operator=(const Ikev2DartPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace ikev2_dart

#endif  // FLUTTER_PLUGIN_IKEV2_DART_PLUGIN_H_
