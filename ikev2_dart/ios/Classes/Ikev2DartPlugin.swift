import Flutter
import UIKit

@available(iOS 13.0.0, *)
public class Ikev2DartPlugin: NSObject, FlutterPlugin {
    
    @Lateinit static var channel: FlutterMethodChannel
    
    public static func register(with registrar: FlutterPluginRegistrar) {
    channel = FlutterMethodChannel(name: "ikev2_dart", binaryMessenger: registrar.messenger())
        
    let stateChannel = FlutterEventChannel(name: "ikev2_dart_states", binaryMessenger: registrar.messenger())
    //let trafficChannel = FlutterEventChannel(name: "ikev2_dart_traffic", binaryMessenger: registrar.messenger())

    let instance = Ikev2DartPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    stateChannel.setStreamHandler((VPNStateHandler() as! FlutterStreamHandler & NSObjectProtocol))
    stateChannel.setStreamHandler((iTrafficHandler() as! FlutterStreamHandler & NSObjectProtocol))
    
    channel.setMethodCallHandler {
      (call: FlutterMethodCall, result: FlutterResult) -> Void in
      if call.method == "connect" {
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
      } else if call.method == "reconnect" {
        VpnService.shared.reconnect(result: result)
      } else if call.method == "disconnect" {
        VpnService.shared.disconnect(result: result)
      } else if call.method == "getCurrentState" {
        VpnService.shared.getState(result: result)
      }
        else if call.method == "saveFile" {
            let args = call.arguments! as! [NSString: NSString]
            VpnService.shared.saveFile(result: result,
                                       path: args["path"]! as String,
                                       file: args["file"]! as String
            )
        }
    }
  }
    
    static func updateVpnState(newState: FlutterVpnState){
        channel.invokeMethod("updateVpnState", arguments: newState.rawValue)
    }
    
}
