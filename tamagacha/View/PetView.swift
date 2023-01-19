//
//  PetView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/17/23.
//

import Foundation
import SwiftUI


struct PetView: View {
    
    let viewModel = PetViewModel()
    
    var body: some View {
        Text("Pet")
    }
}

struct PetView_Previews: PreviewProvider {
    static var previews: some View {
        PetView()
    }
}

