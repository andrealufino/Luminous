//
//  Luminous+Audio.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 10/11/2019.
//

import AVFoundation
import Foundation


extension Luminous {
    
    // MARK: Audio
    
    public struct Audio {
        
        /// A value in the range `0.0` to `1.0`, with `0.0` representing the minimum volume and `1.0` representing the maximum volume.
        public static var currentAudioOutputVolume: Double? {
            
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setActive(true)
                let volume = audioSession.outputVolume
                try audioSession.setActive(false)
                return Double(volume)
            } catch {
                print("Luminous - Failed to activate audio session.")
                return nil
            }
        }
        
        /// The value is true when another application with a non-mixable audio session is playing audio.
        public static var secondaryAudioShouldBeSilencedHint: Bool {
            
            return AVAudioSession.sharedInstance().secondaryAudioShouldBeSilencedHint
        }
    }
}
