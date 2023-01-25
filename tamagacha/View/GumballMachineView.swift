//
//  Gumball Machine View.swift
//  tamagacha
//
//  Created by Porter Dover on 1/23/23.
//

import SwiftUI

struct GumballMachineView: View {
    
    @EnvironmentObject var viewModel: PetViewModel
    @StateObject var gumballViewModel = GumballMachineViewModel()
    
    var body: some View {
        VStack(spacing: 50) {
            Text("Get a new pet!")
                .bold()
                .font(.largeTitle)
            Spacer()
            Image("gumball")
                .resizable()
                .scaledToFit()
            Button("Roll Pet") {
                viewModel.pet = gumballViewModel.getPet()
                viewModel.saveData()
                
            }
            .foregroundColor(.white)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
            )
            .padding()
            Spacer()
        }
    }
}

struct GumballMachineViewPreviews: PreviewProvider {
    static var previews: some View {
        GumballMachineView()
    }
}
