//
//  Luminous+Application.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 10/11/2019.
//

import Foundation
import UIKit


extension Luminous {
    
    // MARK: Application
    
    /// Application information.
    public struct Application {
        
        /// The current app version.
        public static var version: String {
            
            return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        }
        
        /// The build number.
        public static var build: String {
            
            return Bundle.main.infoDictionary?["CFBundleVersion"] as! String
        }
        
        /// The complete app version with build number (i.e. : "2.1.3 (343)").
        public static var completeAppVersion: String {
            
            return "\(Application.version) (\(Application.build))"
        }
        
        /// The current content of the clipboard (only string).
        public static var clipboardString: String? {
            
            return UIPasteboard.general.string
        }
    }
}
