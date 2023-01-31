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

//class SettingsUserDefaults {
//    private var SETTINGS_KEY = "SETTINGS_KEY"
//    private var setting: SettingsUserDefaults
//    var settingsLoaded = false
//
//    init() {
//        if let data = UserDefaults.standard.data(forKey: SETTINGS_KEY) {
//            if let decoded = try? JSONDecoder().decode(SettingsView.self, from: data) {
//                self.setting = decoded
//                print("Pet data successfully retrieved!")
//                self.settingsLoaded = true
//                return
//            }
//        }
//
//        self.setting
//
//
//    }
//
//}
