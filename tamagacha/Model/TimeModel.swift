//
//  TimeModel.swift
//  tamagacha
//
//  Created by Porter Dover on 1/17/23.
//

import Foundation

class PetUserDefaults {
    private var PET_KEY = "PET_KEY"
    private var pet: Pet
    var petLoaded = false
    
    init() {
        if let data = UserDefaults.standard.data(forKey: PET_KEY) {
            if let decoded = try? JSONDecoder().decode(Pet.self, from: data) {
                self.pet = decoded
                print("Pet data successfully retrieved!")
                self.petLoaded = true
                return
            }
        }

        self.pet = Pet(name: "Steve", image: "TESTBIRD", petType: .dog, maxHunger: 100, hunger: 100, maxThirst: 100, thirst: 100, maxHygiene: 100, hygiene: 100, maxLove: 100, love: 100, description: "This pet is quite rare. Only obtain in explicit and illegal ways. Due to the difficulties, only super rich people tend to take care of them. To be honest, its not a great pet. Super annoying.")
        

    }
    
    func deleteData() {
        UserDefaults.standard.removeObject(forKey: PET_KEY)
    }
    
    func loadData() -> Pet {
        var loadedPet = self.pet
        let offlineDecrease = CGFloat(calculateTimeSince(data: loadedPet.lastUpdated)) / CGFloat(Pet.decreaseTime)
        loadedPet.hunger -= CGFloat(offlineDecrease)
        if loadedPet.hunger <= 0 {
            loadedPet.isAlive = false
            loadedPet.hunger = 0
        }
        loadedPet.thirst -= CGFloat(offlineDecrease)
        if loadedPet.thirst <= 0 {
            loadedPet.isAlive = false
            loadedPet.thirst = 0
        }
        loadedPet.hygiene -= CGFloat(offlineDecrease)
        if loadedPet.hygiene <= 0 {
            loadedPet.isAlive = false
            loadedPet.hygiene = 0
        }
        loadedPet.love -= CGFloat(offlineDecrease)
        if loadedPet.love <= 0 {
            loadedPet.isAlive = false
            loadedPet.love = 0
        }
        return loadedPet
    }
    
    func saveData(pet: Pet) {
        let data = try! JSONEncoder().encode(pet)
        UserDefaults.standard.setValue(data, forKey: PET_KEY)
        UserDefaults.standard.synchronize()
        print("Pet Data saved at: \(Date().formatted(date: .omitted, time: .standard))")
    }
}

func calculateTimeSince(data: Date) -> Int {
    let seconds = Int(-data.timeIntervalSinceNow)
    return seconds
}

class SettingsUserDefaults {
    private static var SETTINGS_KEY = "SETTINGS_KEY"
    static var VOLUME_KEY: String { "\(SETTINGS_KEY)_VOLUME" }
    private static var SFX_KEY = "SFX_KEY"
    static var SFXVOLUME_KEY: String { "\(SFX_KEY)_VOLUME" }
    
    static let instance = SettingsUserDefaults()
    
    var volume: Double = 0.5
    var sfxVolume: Double = 0.5
    
    init() {
        self.volume = UserDefaults.standard.double(forKey: SettingsUserDefaults.VOLUME_KEY)
        self.sfxVolume = UserDefaults.standard.double(forKey: SettingsUserDefaults.SFXVOLUME_KEY)
    }
    
    func saveVolume(_ volume: Double) {
        self.volume = volume
        UserDefaults.standard.setValue(volume, forKey: SettingsUserDefaults.VOLUME_KEY)
    }
    
    func saveSFXVolume(_ volume: Double) {
        self.sfxVolume = volume
        UserDefaults.standard.setValue(volume, forKey: SettingsUserDefaults.SFXVOLUME_KEY)
    }
    
    func retrieveVolume() -> Double {
        UserDefaults.standard.double(forKey: SettingsUserDefaults.VOLUME_KEY)
    }
    
    func retrieveSFXVolume() -> Double {
        UserDefaults.standard.double(forKey: SettingsUserDefaults.SFXVOLUME_KEY)
    }
}

class SettingsVM: ObservableObject {
    
    @Published var volume = 0.5 {
        didSet { saveVolume() }
    }
    
    @Published var SFXVolume = 0.5 {
        didSet { saveSFXVolume() }
    }
    
    init() {
        getSettingsInfoFromUserDefaults()
    }
    
    func saveVolume() {
        SettingsUserDefaults.instance.saveVolume(volume)
    }
    
    func saveSFXVolume() {
        SettingsUserDefaults.instance.saveSFXVolume(SFXVolume)
    }
    
    func getSettingsInfoFromUserDefaults() {
        // Do what the function title says
        volume = SettingsUserDefaults.instance.volume
        SFXVolume = SettingsUserDefaults.instance.sfxVolume
    }
}
