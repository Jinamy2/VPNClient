//
//  RouteManager.swift
//  ikev2_dart
//
//

import Foundation
import NetworkExtension

class RouteManager {
    var includedRoutes: [NEIPv4Route] = []
    var excludedRoutes: [NEIPv4Route] = []

    func isRouteIncluded(_ route: String) -> Bool {
        return includedRoutes.contains(NEIPv4Route(destinationAddress: route, subnetMask: "255.0.0.0"))
    }

    func isRouteExcluded(_ route: String) -> Bool {
        return excludedRoutes.contains(NEIPv4Route(destinationAddress: route, subnetMask: "255.0.0.0"))
    }

    func addIncludedRoute(_ route: String) {
        includedRoutes.append(NEIPv4Route(destinationAddress: route, subnetMask: "255.0.0.0"))
    }

    func addExcludedRoute(_ route: String) {
        excludedRoutes.append(NEIPv4Route(destinationAddress: route, subnetMask: "255.0.0.0"))
    }

    func removeIncludedRoute(_ route: String) {
        if let index = includedRoutes.firstIndex(of: NEIPv4Route(destinationAddress: route, subnetMask: "255.0.0.0")) {
            includedRoutes.remove(at: index)
        }
    }

    func removeExcludedRoute(_ route: String) {
        if let index = excludedRoutes.firstIndex(of: NEIPv4Route(destinationAddress: route, subnetMask: "255.0.0.0")) {
            excludedRoutes.remove(at: index)
        }
    }
}
