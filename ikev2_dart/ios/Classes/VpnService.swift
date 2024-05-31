import Flutter
import Foundation
import NetworkExtension
import Security

enum FlutterVpnState: Int {
    case disconnected = 0
    case connecting = 1
    case connected = 2
    case disconnecting = 3
    case error = 4
}

@available(iOS 13.0, *)
class VpnService {
    /// Packet tunnel provider.
    private weak var packetTunnelProvider: NEPacketTunnelProvider?

    // MARK: - Singleton
    static let shared: VpnService = {
        let instance = VpnService()
        return instance
    }()

    var dataUsage: DataUsage?

    // MARK: - Few variables

    var vpnManager: NEVPNManager {
        return NEVPNManager.shared()
    }

    var vpnStatus: NEVPNStatus {
        return vpnManager.connection.status
    }

    let kcs = KeychainService()
    var configurationSaved = false

    // MARK: - Init

    init() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name.NEVPNStatusDidChange, object: nil, queue: OperationQueue.main, using: statusChanged)
        dataUsage = DataUsage()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        dataUsage = nil
    }
    
    private func documentDirectory() -> String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                    .userDomainMask,
                                                                    true)
        return documentDirectory[0]
    }
    
    private func read(fromDocumentsWithFileName fileName: String) {
        guard let filePath = self.append(toPath: self.documentDirectory(),
                                         withPathComponent: fileName) else {
                                            return
        }
        
        do {
            let savedString = try String(contentsOfFile: filePath)
            
            print(savedString)
        } catch {
            print("Error reading saved file")
        }
    }
    
    private func append(toPath path: String,
                        withPathComponent pathComponent: String) -> String? {
        if var pathURL = URL(string: path) {
            pathURL.appendPathComponent(pathComponent)
            print(pathURL.absoluteString)
            
            return pathURL.absoluteString
        }
        
        return nil
    }
    
    //save file cert in iPhone
    func saveFile(result: FlutterResult, path: String, file: String) {
        guard let filePath = self.append(toPath: self.documentDirectory(),
                                             withPathComponent: "ca-cert.pem") else {
                return
            }
            
            do {
                try file.write(toFile: filePath,
                               atomically: true,
                               encoding: .utf8)
            } catch {
                print("Error", error)
                return
            }
            
            print("Save successful")
           self.read(fromDocumentsWithFileName: "ca-cert.pem")
        result(nil)
    }

    // MARK: - Methods

    func connect(
        result: FlutterResult,
        type: String,
        server: String,
        username: String,
        password: String,
        secret: String?,
        description _: String?
    ) {
        vpnManager.loadFromPreferences { error in
            guard error == nil else {
                let msg = "VPN Preferences error: \(error!.localizedDescription)"
                debugPrint(msg)
                VPNStateHandler.updateState(FlutterVpnState.error.rawValue, errorMessage: msg)
                return
            }

            let passwordKey = "vpn_\(type)_password"
            let secretKey = "vpn_\(type)_secret"
            self.kcs.save(key: passwordKey, value: password)
            if let secret = secret {
                self.kcs.save(key: secretKey, value: secret)
            }

            if type == "IPSec" {
                let p = NEVPNProtocolIPSec()
                p.serverAddress = server
                p.username = username
                p.passwordReference = self.kcs.load(key: passwordKey)

                p.authenticationMethod = NEVPNIKEAuthenticationMethod.sharedSecret
                if secret != nil {
                    p.sharedSecretReference = self.kcs.load(key: secretKey)
                }

                p.localIdentifier = ""
                p.remoteIdentifier = ""

                p.useExtendedAuthentication = true
                p.disconnectOnSleep = false
                
                self.vpnManager.protocolConfiguration = p
            } else {
                let p = NEVPNProtocolIKEv2()
                p.username = username
                p.remoteIdentifier = server
                p.serverAddress = server

                p.passwordReference = self.kcs.load(key: passwordKey)
                p.authenticationMethod = NEVPNIKEAuthenticationMethod.none

                p.useExtendedAuthentication = true
                p.disconnectOnSleep = false
                self.vpnManager.protocolConfiguration = p
            }

            self.vpnManager.localizedDescription = "VPNClient"
            self.vpnManager.isOnDemandEnabled = false
            self.vpnManager.isEnabled = true            

            self.vpnManager.saveToPreferences(completionHandler: { error in
                guard error == nil else {
                    let msg = "VPN Preferences error: \(error!.localizedDescription)"
                    debugPrint(msg)
                    VPNStateHandler.updateState(FlutterVpnState.error.rawValue, errorMessage: msg)
                    return
                }

                self.vpnManager.loadFromPreferences(completionHandler: { error in
                    guard error == nil else {
                        let msg = "VPN Preferences error: \(error!.localizedDescription)"
                        debugPrint(msg)
                        VPNStateHandler.updateState(FlutterVpnState.error.rawValue, errorMessage: msg)
                        return
                    }

                    self.configurationSaved = true
                    self.startTunnel()
                })
            })
        }
        result(nil)
    }

    func startTunnel() {
        do {
            try vpnManager.connection.startVPNTunnel()
        } catch let error as NSError {
            var errorStr = ""
            switch error {
            case NEVPNError.configurationDisabled:
                errorStr = "The VPN configuration associated with the NEVPNManager is disabled."
            case NEVPNError.configurationInvalid:
                errorStr = "The VPN configuration associated with the NEVPNManager object is invalid."
            case NEVPNError.configurationReadWriteFailed:
                errorStr = "An error occurred while reading or writing the Network Extension preferences."
            case NEVPNError.configurationStale:
                errorStr = "The VPN configuration associated with the NEVPNManager object was modified by some other process since the last time that it was loaded from the Network Extension preferences by the app."
            case NEVPNError.configurationUnknown:
                errorStr = "An unspecified error occurred."
            case NEVPNError.connectionFailed:
                errorStr = "The connection to the VPN server failed."
            default:
                errorStr = "Unknown error: \(error.localizedDescription)"
            }

            let msg = "Start error: \(errorStr)"
            debugPrint(msg)
            if msg != "Start error: The VPN configuration associated with the NEVPNManager object is invalid."
            { VPNStateHandler.updateState(FlutterVpnState.error.rawValue, errorMessage: msg) }
            return
        }
    }

    func reconnect(result: FlutterResult) {
        guard configurationSaved == true else {
            result(FlutterError(code: "-1",
                                message: "Configuration is not yet saved",
                                details: nil))
            return
        }

        result(nil)
    }

    func disconnect(result: FlutterResult) {
        vpnManager.connection.stopVPNTunnel()
        result(nil)
    }

    func getState(result: FlutterResult) {
        switch vpnStatus {
        case .connecting:
            result(FlutterVpnState.connecting.rawValue)
        case .connected:
            result(FlutterVpnState.connected.rawValue)
        case .disconnecting:
            result(FlutterVpnState.disconnecting.rawValue)
        case .disconnected:
            result(FlutterVpnState.disconnected.rawValue)
        case .invalid:
            result(FlutterVpnState.disconnected.rawValue)
        case .reasserting:
            result(FlutterVpnState.connecting.rawValue)
            break
        @unknown default:
            debugPrint("Unknown switch statement: \(vpnStatus)")
        }
    }

    // MARK: - Event callbacks

    func statusChanged(_: Notification?) {
        Ikev2DartPlugin.updateVpnState(newState: vpnStatus.toFlutterVpnState())
        switch vpnStatus {
        case .connected:
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            VPNStateHandler.updateState(FlutterVpnState.connected.rawValue)
            
            dataUsage?.startMonitoringDataUsageAndSpeed(
                dataUsageCallback: { dataUsageMap in
                    let upStream = dataUsageMap["uploadSpeed"] ?? 0
                    let downStream = dataUsageMap["downloadSpeed"] ?? 0
                    let totalUpStream = dataUsageMap["totalUpload"] ?? 0
                    let totalDownStream = dataUsageMap["totalDownload"] ?? 0

                    iTrafficHandler.updateTraffic(upStream: upStream, downStream: downStream, totalUpStream: totalUpStream, totalDownStream: totalDownStream)
                }
            )

        case .disconnected:
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            VPNStateHandler.updateState(FlutterVpnState.disconnected.rawValue)
            dataUsage?.stopMonitoringDataUsageAndSpeed()
        case .connecting:
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            VPNStateHandler.updateState(FlutterVpnState.connecting.rawValue)

        case .disconnecting:
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            VPNStateHandler.updateState(FlutterVpnState.disconnecting.rawValue)

        case .invalid:
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            //VPNStateHandler.updateState(FlutterVpnState.error.rawValue)

        case .reasserting:
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            VPNStateHandler.updateState(FlutterVpnState.connecting.rawValue)
            break

        @unknown default:
            debugPrint("Unknown switch statement: \(vpnStatus)")
        }
    }
}

extension NEVPNStatus{
    func toFlutterVpnState()-> FlutterVpnState{
        switch self {
        case .invalid:
            return .error
        case .disconnected:
            return .disconnected
        case .connecting:
            return .connecting
        case .connected:
            return .connected
        case .reasserting:
            return .connecting
        case .disconnecting:
            return .disconnecting
        @unknown default:
            return .error
        }
    }
}
