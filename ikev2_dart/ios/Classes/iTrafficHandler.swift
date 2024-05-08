//
//  iTrafficMeasurer.swift
//  flutter_vpn
//
//  Created by nhCoder on 01/04/2023.
//

import Foundation
import Flutter


class iTrafficHandler: FlutterStreamHandler{
    
    static var _sink:FlutterEventSink?
    
    static func updateTraffic(upStream: Int64, downStream: Int64, totalUpStream: Int64, totalDownStream: Int64){
        
        guard let sink = _sink else {
            return
        }
        let dataUsageInfo: [String: Int64] = [
            "uploadSpeed": upStream,
            "downloadSpeed": downStream,
            "totalUpload": totalUpStream,
            "totalDownload": totalDownStream
        ]
        sink(dataUsageInfo)
    }
    
    
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        iTrafficHandler._sink=events;
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        iTrafficHandler._sink = nil
        return nil
    }
}
