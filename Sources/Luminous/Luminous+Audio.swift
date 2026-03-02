//
//  Luminous+Audio.swift
//  Luminous
//
//  Created by Andrea Mario Lufino on 10/11/2019.
//

import AVFoundation
import Foundation


// MARK: - Audio

extension Luminous {

    /// Audio output information.
    public struct Audio: Sendable {

        /// The current audio output volume, in the range `0.0` to `1.0`.
        ///
        /// Reads `AVAudioSession.outputVolume` directly without activating the
        /// session, avoiding the harmful side-effect of interrupting other audio.
        /// Returns `nil` if the value is outside the expected range.
        public static var currentAudioOutputVolume: Float? {
            let volume = AVAudioSession.sharedInstance().outputVolume
            guard volume >= 0 else { return nil }
            return volume
        }

        /// Whether another app with a non-mixable audio session is playing audio.
        ///
        /// When `true`, the app should silence its secondary audio.
        public static var secondaryAudioShouldBeSilencedHint: Bool {
            AVAudioSession.sharedInstance().secondaryAudioShouldBeSilencedHint
        }

        /// Whether a wired headset (headphones with or without a microphone) is
        /// plugged in to the 3.5 mm jack or Lightning/USB-C port.
        ///
        /// Returns `false` for Bluetooth audio devices; use
        /// `isAnyHeadphoneConnected` to include those.
        public static var isWiredHeadsetPluggedIn: Bool {
            AVAudioSession.sharedInstance().currentRoute.outputs.contains {
                $0.portType == .headphones
            }
        }

        /// Whether any headphone or Bluetooth audio device is connected.
        ///
        /// Returns `true` for wired headphones, AirPods, Bluetooth A2DP,
        /// Bluetooth HFP, and Bluetooth LE audio devices.
        public static var isAnyHeadphoneConnected: Bool {
            let headphonePorts: Set<AVAudioSession.Port> = [
                .headphones, .bluetoothA2DP, .bluetoothHFP, .bluetoothLE
            ]
            return AVAudioSession.sharedInstance().currentRoute.outputs.contains {
                headphonePorts.contains($0.portType)
            }
        }
    }
}
