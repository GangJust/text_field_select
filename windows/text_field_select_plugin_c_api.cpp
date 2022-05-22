#include "include/text_field_select/text_field_select_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "text_field_select_plugin.h"

void TextFieldSelectPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  text_field_select::TextFieldSelectPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
