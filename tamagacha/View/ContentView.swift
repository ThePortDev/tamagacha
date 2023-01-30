//
//  ContentView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/17/23.
//

import SwiftUI

struct MenuView: View {
    
    @State private var fadeInOut = false
    
    @EnvironmentObject var viewModel: PetViewModel
    
    @State var navigateToHomeView = false
    @State var navigateToGumballView = false
    @State var navigateToDeathView = false
    
    var body: some View {
        VStack {
            title
            Spacer()
            ZStack {
                background
                petPick
            }
            Spacer()
            tapToGo
            Spacer()
        }
        .background(.gray)
        .onAppear {
            SoundManager.soundInstance.playSound(sound: .zoid)
        }
        .onTapGesture {
            if viewModel.userDefaultPet.petLoaded && viewModel.pet.isAlive {
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
    
    var title: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .fill(AngularGradient(colors: [.blue, .white], center: .topLeading))
                .frame(width: 280, height: 100)
                .shadow(
                    color: .black.opacity(0.5),
                    radius: 10,
                    x:0.0, y:10)
            Text("Tamagacha")
                .foregroundColor(.black)
                .font(.custom("HangTheDJ", size: 40))
                .bold()
                .colorInvert()
        }
    }
    
    var petPick: some View {
        Image("TESTDOG")
            .resizable()
            .frame(width: 180, height: 160)
            .position(x:190, y:190)
            
    }
    
    var background: some View {
        Image("GamePad")
            .resizable()
            .frame(width: 300, height: 500)
            .shadow(
                color: .black.opacity(0.7),
                radius: 15,
                x:0.0, y:10
            )
    }
    
    var tapToGo: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .fill(AngularGradient(colors: [.blue, .white], center: .topLeading))
                .frame(width: 280, height: 50)
                .shadow(
                    color: .black.opacity(0.5),
                    radius: 10,
                    x:0.0, y:10)
            Text("Tap To Start")
                .foregroundColor(.black)
                .font(.custom("HangTheDJ", size: 30))
                .bold()
                .colorInvert()
                .onAppear() {
                    withAnimation(Animation.easeInOut(duration: 0.6)
                        .repeatForever(autoreverses: true)) {
                            fadeInOut.toggle()
                        }
                }.opacity(fadeInOut ? 0 : 1)
        }
    }

}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environmentObject(PetViewModel())
    }
}

