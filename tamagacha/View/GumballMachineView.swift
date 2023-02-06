//
//  Gumball Machine View.swift
//  tamagacha
//
//  Created by Porter Dover on 1/23/23.
//

import SwiftUI

struct GumballMachineView: View {
    @StateObject var DeadPetsVM: DeadPetUserDefaults
    @State private var showingPopover = false
    
    @EnvironmentObject var viewModel: PetViewModel
    @StateObject var gumballViewModel = GumballMachineViewModel()
    
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Let's Adopt A Pet!")
                .bold()
                .font(.custom("HangTheDJ", size: 34))
                .foregroundColor(.blue)
            Spacer()
            GifView(name: "gumball2.gif")
            Button {
                SoundManager.soundInstance.playSound(sound: .click)
                viewModel.pet = gumballViewModel.getPet()
                viewModel.saveData()
                showingPopover = true
            } label: {
                ZStack {
                    RoundedRectangle(cornerSize: CGSize(width: 100, height: 100))
                        .fill(AngularGradient(colors: [.blue, .white], center: .topLeading))
                        .frame(width: 180, height: 35)
                        .shadow(
                            color: .black.opacity(0.5),
                            radius: 10,
                            x:0.0, y:10
                        )
                    Text("Roll Your Pet!")
                        .font(.custom("HangTheDJ", size: 18))
                        .colorInvert()
                        .foregroundColor(.black)
                        .bold()
                        .italic()
                }
                .navigate(to: PopOverView(DeadPetsVM: DeadPetsVM), when: $showingPopover)
            }
            
        }
        .onAppear {
            SoundManager.soundInstance.stopMusic()
            SoundManager.soundInstance.playMusic(sound: .zoid)
        }
    }
    
}


struct GumballMachineViewPreviews: PreviewProvider {
    static var previews: some View {
        GumballMachineView(DeadPetsVM: DeadPetUserDefaults())
    }
}

//MARK: Get random pet and save data
//viewModel.pet = gumballViewModel.getPet()
//viewModel.saveData()
