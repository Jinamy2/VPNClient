#include "include/ikev2_dart/ikev2_dart_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "ikev2_dart_plugin.h"

void Ikev2DartPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  ikev2_dart::Ikev2DartPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
