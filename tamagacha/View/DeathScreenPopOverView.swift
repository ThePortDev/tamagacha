//
//  DeathScreenPopOverView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/23/23.
//

import SwiftUI

struct DeathScreenPopOverView: View {
    @StateObject var DeadPetsVM: DeadPetUserDefaults
    @State private var showingPopover = false
    
    @StateObject var viewModel = PetViewModel()
    
    var body: some View {
        VStack {
            deathWords
            Spacer()
            petDeadText
            Spacer()
            tombStone
            Spacer()
            returnToGumball
            Spacer()
            writeOdeToPet
            
            
        }
        .background(
            Image("cemetery")
                .resizable()
                .frame(width: 450,height: 980)
        )
        .onAppear {
            SoundManager.soundInstance.stopMusic()
            SoundManager.soundInstance.playMusic(sound: .gloomy)
        }
    }
    
    
    var petDeadText: some View {
        Text("\(PetViewModel().pet.name) is super dead.")
            .font(.custom("Yoster Island", size: 20))
            .bold()
            .foregroundColor(ThemeColors.primaryText)
            .padding()
            .background(
                RoundedRectangle(cornerSize: CGSize(width: 100, height: 200))
                    .fill(AngularGradient(colors: [.white, .black], center: .topLeading))
                    .shadow(
                        color: .black.opacity(0.5),
                        radius: 10,
                        x:0.0, y:10
                    )
            )
        
    }
    
    var tombStone: some View {
        GifView(name: "ghost3")
            .frame(width: 300, height: 300)
            .background(
                AngularGradient(colors: [.white, .black], center: .topLeading)
                    .cornerRadius(20)
                    .shadow(
                        color: .black.opacity(0.5),
                        radius: 10,
                        x: 0.0, y: 5))
    }
    
    var deathWords: some View {
        Text("- Memento Mori -")
            .font(.custom("Yoster Island", size: 20))
            .bold()
            .italic()
            .foregroundColor(ThemeColors.accentButton)
    }
    
    @State var goToGumball = false
    
    var returnToGumball: some View {
        Button {
            goToGumball = true
        } label: {
            Text("Replace \(viewModel.pet.name)?")
                .font(.custom("Yoster Island", size: 26))
                .foregroundColor(ThemeColors.primaryText)
                .bold()
                .padding()
                .background(
                    RoundedRectangle(cornerSize: CGSize(width: 100, height: 100))
                        .fill(AngularGradient(colors: [ThemeColors.accentButton, .black], center: .topLeading))
                        .shadow(
                            color: .black.opacity(0.5),
                            radius: 10,
                            x:0.0, y:10)
                )
        }
        .onTapGesture {
            SoundManager.soundInstance.playSound(sound: .click)
        }
        .navigate(to: GumballMachineView(DeadPetsVM: DeadPetsVM), when: $goToGumball)
    }
    
    @State var goToOde = false
    
    var writeOdeToPet: some View {
        Button {
            goToOde = true
        } label: {
            Text("Bury \(viewModel.pet.name)? 💲50")
                .font(.custom("Yoster Island", size: 26))
                .foregroundColor(ThemeColors.primaryText)
                .bold()
                .padding()
                .background(
                    RoundedRectangle(cornerSize: CGSize(width: 100, height: 100))
                        .fill(AngularGradient(colors: [ThemeColors.accentButton, .black], center: .topLeading))
                        .shadow(
                            color: .black.opacity(0.5),
                            radius: 10,
                            x:0.0, y:10)
                )
        }
        .navigate(to: ObituaryView(DeadPetsVM: DeadPetsVM), when: $goToOde)
    }
    
}


struct DeathScreenPopOverView_Previews: PreviewProvider {
    static var previews: some View {
        DeathScreenPopOverView(DeadPetsVM: DeadPetUserDefaults())
    }
}
