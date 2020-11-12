#import "AnimatedThemeSwitcherPlugin.h"
#if __has_include(<animated_theme_switcher/animated_theme_switcher-Swift.h>)
#import <animated_theme_switcher/animated_theme_switcher-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "animated_theme_switcher-Swift.h"
#endif

@implementation AnimatedThemeSwitcherPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAnimatedThemeSwitcherPlugin registerWithRegistrar:registrar];
}
@end
