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
    var soundPlayer: AVAudioPlayer?
    
    enum MusicOption: String {
        case zoid = "retro-game"
        case gloomy = "sad"
    }
    
    enum SoundOption: String {
        case hooray = "hooray"
        case click = "click"
        case plop = "plop"
        case chaching = "chaching"
        case recieved = "recieved"
        case swoosh = "swoosh"
        case shower = "shower"
        case type = "type"
        case boing = "boing"
    }
    
    func playMusic(sound: MusicOption) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.volume = Float(SettingsUserDefaults.instance.retrieveVolume())
            player?.prepareToPlay()
            player?.play()
            player?.numberOfLoops = -1
        } catch let error {
            print("Error playing music. \(error.localizedDescription)")
        }
    }
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: url)
            soundPlayer?.volume = Float(SettingsUserDefaults.instance.retrieveSFXVolume())
            soundPlayer?.prepareToPlay()
            soundPlayer?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
    
    func stopSound() {
        soundPlayer?.stop()
    }
    
    func stopMusic() {
        player?.stop()
    }
    
}
