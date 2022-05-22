#import "TextFieldSelectPlugin.h"
#if __has_include(<text_field_select/text_field_select-Swift.h>)
#import <text_field_select/text_field_select-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "text_field_select-Swift.h"
#endif

@implementation TextFieldSelectPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTextFieldSelectPlugin registerWithRegistrar:registrar];
}
@end
