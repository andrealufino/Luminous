//
//  Luminous+Network.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 10/11/2019.
//

import Foundation
import Network
import SystemConfiguration.CaptiveNetwork


extension Luminous {


    // MARK: - Network

    /// Network information.
    public struct Network {

        // MARK: Private

        /// Internal singleton that monitors the current network path.
        ///
        /// Uses `NWPathMonitor` to deliver the initial path synchronously on first access,
        /// then keeps updating in the background for all subsequent reads.
        private static let monitor: PathMonitor = PathMonitor()

        private final class PathMonitor {

            private let nwMonitor = NWPathMonitor()
            private let queue = DispatchQueue(label: "com.luminous.pathMonitor", qos: .utility)
            private let lock = NSLock()
            private var _currentPath: NWPath?

            var currentPath: NWPath? {
                lock.lock()
                defer { lock.unlock() }
                return _currentPath
            }

            init() {
                let semaphore = DispatchSemaphore(value: 0)
                var signalled = false

                nwMonitor.pathUpdateHandler = { [weak self] path in
                    guard let self else { return }
                    self.lock.lock()
                    let isFirst = self._currentPath == nil
                    self._currentPath = path
                    self.lock.unlock()
                    if isFirst && !signalled {
                        signalled = true
                        semaphore.signal()
                    }
                }

                nwMonitor.start(queue: queue)
                semaphore.wait()
            }
        }


        // MARK: Public Properties

        /// Check if the device is connected via WiFi.
        public static var isConnectedViaWiFi: Bool {
            monitor.currentPath?.usesInterfaceType(.wifi) ?? false
        }

        /// Check if the device is connected via cellular.
        public static var isConnectedViaCellular: Bool {
            monitor.currentPath?.usesInterfaceType(.cellular) ?? false
        }

        /// Check if internet is available (any satisfied connection).
        public static var isInternetAvailable: Bool {
            monitor.currentPath?.status == .satisfied
        }

        /// Get the network SSID. Does not work in the Simulator.
        ///
        /// Deprecated since iOS 13: `CNCopySupportedInterfaces` is no longer accessible
        /// without the "Access WiFi Information" entitlement, and returns empty results
        /// in most contexts.
        @available(iOS, deprecated: 13.0, message: "SSID access via CNCopySupportedInterfaces is no longer reliable on iOS 13+.")
        public static var SSID: String {
            var currentSSID = ""

            guard let interfaces = CNCopySupportedInterfaces() as? [String] else {
                return currentSSID
            }

            for interface in interfaces {
                guard
                    let info = CNCopyCurrentNetworkInfo(interface as CFString) as? [String: Any],
                    let ssid = info["SSID"] as? String
                else { continue }
                currentSSID = ssid
                break
            }

            return currentSSID
        }
    }
}
