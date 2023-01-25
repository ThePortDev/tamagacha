//
//  ContentView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/17/23.
//

import SwiftUI

struct MenuView: View {
    
    @EnvironmentObject var viewModel: PetViewModel
    
    @State var navigateToHomeView = false
    @State var navigateToGumballView = false
    @State var navigateToDeathView = false
    
    var body: some View {
        ZStack {
            Text("Tamagacha")
        }
        .background(
            Image("cheesepuffs")
                .resizable()
                .frame(width: screenWidth, height: screenHeight)
        )
        .onTapGesture {
            if viewModel.userDefaultPet.petLoaded {
                navigateToHomeView = true
            } else if !viewModel.pet.isAlive {
                navigateToDeathView = true
            } else {
                navigateToGumballView = true
            }
        }
        .navigate(to: DeathScreenPopOverView().environmentObject(viewModel), when: $navigateToDeathView)
        .navigate(to: GumballMachineView().environmentObject(viewModel), when: $navigateToGumballView)
        .navigate(to: HomeView().environmentObject(viewModel), when: $navigateToHomeView)

    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

