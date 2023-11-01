import Flutter
import UIKit

public class FlutterSiriShortcutsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    if #available(iOS 12.0, *) {
      let factory = AddToSiriButtonFactory(messenger: registrar.messenger())
      registrar.register(factory, withId: "AddToSiriButton")
    } else {
      print("iOS: Siri shortcuts are not supported")
    }
    
    let channel = FlutterMethodChannel(name: "flutter_siri_shortcuts", binaryMessenger: registrar.messenger())
    let instance = FlutterSiriShortcutsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "presentShortcut":
      if #available(iOS 12.0, *) {
        let args  =  call.arguments as! Dictionary<String, Any>
        ShortcutsHandler().presentShortcut(args)
        result(true)
      } else {
        result(FlutterMethodNotImplemented)
      }
    case "donateShortcut":
      if #available(iOS 12.0, *) {
        let args = call.arguments as! Dictionary<String, Any>
        ShortcutsHandler().donateShortcut(args)
        result(true)
      } else {
        result(FlutterMethodNotImplemented)
      }
    case "clearShortcuts":
      if #available(iOS 12.0, *) {
        result(ShortcutsHandler().clearShortcuts())
      } else {
        result(FlutterMethodNotImplemented)
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
