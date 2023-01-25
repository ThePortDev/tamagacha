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
        model.pets.randomElement() ?? Pet(name: "Broken Pet", image: "cheesepuffs", petType: .slime, maxHunger: 999, maxThirst: 999, maxHygiene: 999, maxLove: 999, description: "This shouldn't be possible.")
    }
}
