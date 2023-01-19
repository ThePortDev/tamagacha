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
        //TODO: add pet hunger var by amount
    }
    
    func giveWater(amount: CGFloat) {
        //TODO: add pet thirst var by amount
    }
    
    func petPet(amount: CGFloat) {
        //TODO: add pet love var by amount
    }
    
    func shower(amount: CGFloat) {
        //TODO: add pet hygiene var by amount
    }
    
}
