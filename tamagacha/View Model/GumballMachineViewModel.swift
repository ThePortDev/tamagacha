//
//  GumballMachineViewModel.swift
//  tamagacha
//
//  Created by Porter Dover on 1/23/23.
//

import Foundation

class GumballMachineViewModel: ObservableObject {
    @Published var model = GumballModel()
    
    func getPet() -> Pet {
        model.pets.randomElement() ?? Pet(name: "Broken Pet", image: "cheesepuffs", petType: .slime, maxHunger: 100, hunger: 100, maxThirst: 100, thirst: 100, maxHygiene: 100, hygiene: 100, maxLove: 100, love: 100, description: "This shouldn't be possible.")
    }
}
