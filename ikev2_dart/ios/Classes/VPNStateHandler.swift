import Flutter
import Foundation

class VPNStateHandler: FlutterStreamHandler {
    static var _sink: FlutterEventSink?

    static func updateState(_ newState: Int, errorMessage: String? = nil) {
        guard let sink = _sink else {
            return
        }

        if errorMessage != nil {
            sink(newState)
            debugPrint("error massage - \(errorMessage?.description)")
            return
        }

        sink(newState)
    }

    func onListen(withArguments _: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        VPNStateHandler._sink = events
        return nil
    }

    func onCancel(withArguments _: Any?) -> FlutterError? {
        VPNStateHandler._sink = nil
        return nil
    }
}
