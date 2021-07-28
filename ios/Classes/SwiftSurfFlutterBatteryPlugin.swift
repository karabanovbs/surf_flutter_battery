import Flutter
import UIKit

public class SwiftSurfFlutterBatteryPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let batteryChannel = FlutterMethodChannel(name: "surf_flutter_battery", binaryMessenger: registrar.messenger())
    let instance = SwiftSurfFlutterBatteryPlugin()
    registrar.addMethodCallDelegate(instance, channel: batteryChannel)
    
    UIDevice.current.isBatteryMonitoringEnabled = true
    NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelDidChange), name: UIDevice.batteryLevelDidChangeNotification, object: nil)
  }

  @objc func batteryLevelDidChange(_ notification: Notification) {
//    batteryChannel.invokeMethod("getBatteryLevel", arguments: 10.0)
  }
        
}
