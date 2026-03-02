//
//  Luminous+Network.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 10/11/2019.
//

import Foundation
import Network


// MARK: - Network

extension Luminous {

    /// Network connectivity information.
    ///
    /// Backed by a shared `NWPathMonitor` that starts once on first access and
    /// updates in the background. The initial path is delivered synchronously so
    /// the first read always returns a valid value.
    public struct Network {

        // MARK: Private

        private static let monitor: PathMonitor = PathMonitor()

        /// Thread-safe wrapper around `NWPathMonitor`.
        ///
        /// Marked `@unchecked Sendable` because thread-safety is enforced manually
        /// through `NSLock`.
        private final class PathMonitor: @unchecked Sendable {

            private let nwMonitor = NWPathMonitor()
            private let queue = DispatchQueue(label: "com.luminous.pathMonitor", qos: .utility)
            private let lock = NSLock()
            private var _currentPath: NWPath?

            var currentPath: NWPath? {
                lock.withLock { _currentPath }
            }

            init() {
                let semaphore = DispatchSemaphore(value: 0)

                nwMonitor.pathUpdateHandler = { [weak self] path in
                    guard let self else { return }
                    var shouldSignal = false
                    self.lock.lock()
                    if self._currentPath == nil {
                        self._currentPath = path
                        shouldSignal = true
                    }
                    self.lock.unlock()
                    if shouldSignal {
                        semaphore.signal()
                    }
                }

                nwMonitor.start(queue: queue)
                semaphore.wait()
            }
        }


        // MARK: Connectivity

        /// Whether the device is currently connected via Wi-Fi.
        public static var isConnectedViaWiFi: Bool {
            monitor.currentPath?.usesInterfaceType(.wifi) ?? false
        }

        /// Whether the device is currently connected via cellular.
        public static var isConnectedViaCellular: Bool {
            monitor.currentPath?.usesInterfaceType(.cellular) ?? false
        }

        /// Whether any satisfied network path is available.
        public static var isInternetAvailable: Bool {
            monitor.currentPath?.status == .satisfied
        }

        // MARK: Path Attributes

        /// Whether the current network path is considered expensive (e.g. cellular
        /// or a personal hotspot).
        ///
        /// Apps should reduce non-essential data usage when this is `true`.
        public static var isExpensive: Bool {
            monitor.currentPath?.isExpensive ?? false
        }

        /// Whether the current network path is constrained by Low Data Mode.
        ///
        /// Apps should defer discretionary transfers when this is `true`.
        public static var isConstrained: Bool {
            monitor.currentPath?.isConstrained ?? false
        }

        /// Whether the current network path supports IPv4.
        public static var supportsIPv4: Bool {
            monitor.currentPath?.supportsIPv4 ?? false
        }

        /// Whether the current network path supports IPv6.
        public static var supportsIPv6: Bool {
            monitor.currentPath?.supportsIPv6 ?? false
        }
    }
}
