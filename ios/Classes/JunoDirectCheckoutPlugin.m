#import "JunoDirectCheckoutPlugin.h"
#if __has_include(<juno_direct_checkout/juno_direct_checkout-Swift.h>)
#import <juno_direct_checkout/juno_direct_checkout-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "juno_direct_checkout-Swift.h"
#endif

@implementation JunoDirectCheckoutPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftJunoDirectCheckoutPlugin registerWithRegistrar:registrar];
}
@end
