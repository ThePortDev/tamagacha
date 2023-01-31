//
//  DeathScreenPopOverView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/23/23.
//

import SwiftUI

struct DeathScreenPopOverView: View {
    @State private var showingPopover = false
    
    @StateObject var viewModel = PetViewModel()
    
    var body: some View {
        VStack {
            deathWords
            Spacer()
            petDeadText
            tombStone
            Spacer()
            returnToGumball
            Spacer()
            
        
        }
        .background(
            Image("cemetary")
                .resizable()
                .frame(width: 400,height: 880)
        )
        .onAppear {
            SoundManager.soundInstance.stopSound()
            SoundManager.soundInstance.playSound(sound: .gloomy)
        }
    }
    
    
    var petDeadText: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 100, height: 200))
                .fill(AngularGradient(colors: [.white, .black], center: .topLeading))
                .frame(width: 300, height: 35)
                .shadow(
                    color: .black.opacity(0.5),
                    radius: 10,
                    x:0.0, y:10
                )
            Text("\(PetViewModel().pet.name) is super dead.")
                .font(.custom("HangTheDJ", size: 20))
                .bold()
                .foregroundColor(.black)
        }
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
        Text("- Memento Mori")
            .font(.title)
            .bold()
            .italic()
            .foregroundColor(.gray)
    }
    
    var returnToGumball: some View {
        NavigationLink {
            GumballMachineView()
        } label: {
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: 100, height: 100))
                    .fill(AngularGradient(colors: [.yellow, .white], center: .topLeading))
                    .frame(width: 280, height: 55)
                    .shadow(
                        color: .black.opacity(0.5),
                        radius: 10,
                        x:0.0, y:10
                    )
                Text("Replace \(PetViewModel().pet.name)?")
                    .font(.custom("HangTheDJ", size: 26))
                    .foregroundColor(.black)
                    .bold()
            }
        }

    }
}

struct DeathScreenPopOverView_Previews: PreviewProvider {
    static var previews: some View {
        DeathScreenPopOverView()
    }
}
