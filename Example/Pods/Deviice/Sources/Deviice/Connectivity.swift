//
//  Connectivity.swift
//  Deviice
//
//  Created by Andrea Mario Lufino on 05/11/21.
//

import Foundation


// MARK: - Connectivity

public enum Connectivity: String {
    case unknown
    case wiFi
    case cellular
}


// MARK: - Connectivity Details

public enum ConnectivityDetails: String {
    case unknown        = "Unknown"
    case wiFi           = "WiFi"
    case wiFi3G         = "WiFi + 3G"
    case wiFi4G         = "WiFi + 4G"
    case wiFi5G         = "WiFi + 5G"
}
