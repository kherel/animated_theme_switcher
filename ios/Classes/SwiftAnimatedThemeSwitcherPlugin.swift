import Flutter
import UIKit

public class SwiftAnimatedThemeSwitcherPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "animated_theme_switcher", binaryMessenger: registrar.messenger())
    let instance = SwiftAnimatedThemeSwitcherPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
