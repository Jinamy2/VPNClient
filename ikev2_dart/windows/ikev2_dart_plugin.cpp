#include "ikev2_dart_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>

namespace ikev2_dart {

// static
void Ikev2DartPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "ikev2_dart",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<Ikev2DartPlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

Ikev2DartPlugin::Ikev2DartPlugin() {}

Ikev2DartPlugin::~Ikev2DartPlugin() {}

void Ikev2DartPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name().compare("connect") == 0) {
    std::cout << "Connect";
    //TODO connect to vpn
    result->Success();
  } else {
    if (method_call.method_name().compare("disconnect") == 0) {
      std::cout << "disconnect";
      result->Success();
      //TODO disconnect vpn
    } else {
     if (method_call.method_name().compare("getCurrentState") == 0) {
      std::cout << "getCurrentState";
      result->Success();
      //TODO get state
    } else {
    result->NotImplemented();
  }
  }
}

}  // namespace ikev2_dart
