//
//  SoundManager.swift
//  tamagacha
//
//  Created by Porter Dover on 1/25/23.
//

import Foundation
import AVKit

class SoundManager {
        
    static let soundInstance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case zoid = "Zoid"
    }
    
    func playSound(sound: SoundOption) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
    
    func stopSound() {
            player?.stop()
    }
    
}
