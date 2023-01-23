//
//  PetViewModel.swift
//  tamagacha
//
//  Created by Porter Dover on 1/17/23.
//

import SwiftUI
import Foundation

class PetViewModel: ObservableObject {
    
    @Published var pet: Pet
    private var userDefaultPet = PetUserDefaults()
    
    init() {
        pet = userDefaultPet.loadData()
    }
    
    func saveData() {
        objectWillChange.send()
        userDefaultPet.saveData(pet: pet)
    }
    
    func feed(amount: CGFloat) {
        pet.hunger += amount
    }
    
    func giveWater(amount: CGFloat) {
        pet.thirst += amount
    }
    
    func petPet(amount: CGFloat) {
        pet.love += amount
    }
    
    func shower(amount: CGFloat) {
        pet.hygiene += amount
    }
    
}
