#import "SurvicateFlutterSdkPlugin.h"
#if __has_include(<survicate_flutter_sdk/survicate_flutter_sdk-Swift.h>)
#import <survicate_flutter_sdk/survicate_flutter_sdk-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "survicate_flutter_sdk-Swift.h"
#endif

@implementation SurvicateFlutterSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSurvicateFlutterSdkPlugin registerWithRegistrar:registrar];
}
@end
