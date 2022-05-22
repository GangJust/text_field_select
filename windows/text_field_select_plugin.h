#ifndef FLUTTER_PLUGIN_TEXT_FIELD_SELECT_PLUGIN_H_
#define FLUTTER_PLUGIN_TEXT_FIELD_SELECT_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace text_field_select {

class TextFieldSelectPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  TextFieldSelectPlugin();

  virtual ~TextFieldSelectPlugin();

  // Disallow copy and assign.
  TextFieldSelectPlugin(const TextFieldSelectPlugin&) = delete;
  TextFieldSelectPlugin& operator=(const TextFieldSelectPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace text_field_select

#endif  // FLUTTER_PLUGIN_TEXT_FIELD_SELECT_PLUGIN_H_
