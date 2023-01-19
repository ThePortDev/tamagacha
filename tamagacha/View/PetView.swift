//
//  PetView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/17/23.
//

import Foundation
import SwiftUI


struct PetView: View {
    
    let viewModel = PetViewModel(pet: Pet(name: "steve", birthday: Date(), lastMeal: Date(), lastDrink: Date(), hygiene: Date()))
    
    var body: some View {
        Text("")
    }
}

struct PetView_Previews: PreviewProvider {
    static var previews: some View {
        PetView()
    }
}

