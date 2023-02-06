//
//  PetView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/17/23.
//

import Foundation
import SwiftUI


struct PetView: View {
    
    @State var viewModel: PetViewModel
    
    var body: some View {
        VStack {
            Text("\(viewModel.pet.name) - \(viewModel.pet.age)")
                .font(.custom("Yoster Island", size: 20))
                .bold()
        }
    }
}

struct PetView_Previews: PreviewProvider {
    static var previews: some View {
        PetView(viewModel: PetViewModel())
    }
}

