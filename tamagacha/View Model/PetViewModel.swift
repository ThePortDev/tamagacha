//
//  PetViewModel.swift
//  tamagacha
//
//  Created by Porter Dover on 1/17/23.
//

import SwiftUI
import Foundation

class PetViewModel {
    
    let petDataModel: Pet
    let timeDataModel = PetUserDefaults()
    
    init(pet: Pet) {
        self.petDataModel = pet
    }
    
    
}
