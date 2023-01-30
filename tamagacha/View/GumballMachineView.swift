//
//  Gumball Machine View.swift
//  tamagacha
//
//  Created by Porter Dover on 1/23/23.
//

import SwiftUI

struct GumballMachineView: View {
    @State private var showingPopover = false
    
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
            Button {
                viewModel.pet = gumballViewModel.getPet()
                viewModel.saveData()
                showingPopover = true
            } label: {
                ZStack {
                    RoundedRectangle(cornerSize: CGSize(width: 100, height: 100))
                        .fill(AngularGradient(colors: [.red, .white], center: .topLeading))
                        .frame(width: 180, height: 35)
                        .shadow(
                            color: .black.opacity(0.5),
                            radius: 10,
                            x:0.0, y:10
                        )
                    Text("Roll Your Pet!")
                        .foregroundColor(.black)
                        .bold()
                        .italic()
                }
                .navigate(to: PopOverView(), when: $showingPopover)
            }
            
        }
        .onAppear {
            SoundManager.soundInstance.stopSound()
            SoundManager.soundInstance.playSound(sound: .zoid)
        }
    }
    
}


struct GumballMachineViewPreviews: PreviewProvider {
    static var previews: some View {
        GumballMachineView()
    }
}

//MARK: Get random pet and save data
//viewModel.pet = gumballViewModel.getPet()
//viewModel.saveData()
