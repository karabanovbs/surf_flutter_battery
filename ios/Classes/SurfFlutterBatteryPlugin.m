#import "SurfFlutterBatteryPlugin.h"
#if __has_include(<surf_flutter_battery/surf_flutter_battery-Swift.h>)
#import <surf_flutter_battery/surf_flutter_battery-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "surf_flutter_battery-Swift.h"
#endif

@implementation SurfFlutterBatteryPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSurfFlutterBatteryPlugin registerWithRegistrar:registrar];
}
@end
