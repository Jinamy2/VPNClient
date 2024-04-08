import Flutter
import UIKit

public class Ikev2DartPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_vpn", binaryMessenger: registrar.messenger())
    let stateChannel = FlutterEventChannel(name: "flutter_vpn_states", binaryMessenger: registrar.messenger())
    let trafficChannel = FlutterEventChannel(name: "flutter_vpn_traffic", binaryMessenger: registrar.messenger())
        let instance = Ikev2DartPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    stateChannel.setStreamHandler((VPNStateHandler() as! FlutterStreamHandler & NSObjectProtocol))
    stateChannel.setStreamHandler((iTrafficHandler() as! FlutterStreamHandler & NSObjectProtocol))

  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "connect":
      {
        let args = call.arguments! as! [NSString: NSString]
        VpnService.shared.connect(
          result: result,
          type: (args["Type"] as? String ?? "IKEv2"),
          server: args["Server"]! as String,
          username: args["Username"]! as String,
          password: args["Password"]! as String,
          secret: args["Secret"] as? String,
          description: args["Name"] as? String
        )
      }
    case "reconnect":
      VpnService.shared.reconnect(result: result)
    case "getCurrentState":
      VpnService.shared.getState(result: result)
    case "disconnect":
      VpnService.shared.disconnect(result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
