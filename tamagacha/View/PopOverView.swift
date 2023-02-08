//
//  PopOverView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/23/23.
//

import SwiftUI

struct PopOverView: View {
    
    @StateObject var DeadPetsVM: DeadPetUserDefaults
    
    @State private var showingPopover = false
    
    @EnvironmentObject var viewModel: PetViewModel
    
    var body: some View {
        VStack {
            VStack {
                Spacer(minLength: 60)
                petNameView
                petImageView
                Spacer(minLength: 20)
                petDescription
                Spacer(minLength: 20)
                stats
                Spacer()
                goHome
                Spacer(minLength: 20)
                
            }
            .onAppear {
                SoundManager.soundInstance.playSound(sound: .recieved)
            }
            .environmentObject(viewModel)
            .background(
                AngularGradient(colors: [.white, .black], center: .topLeading))
            .ignoresSafeArea()
            
        }
    }
    
    //        .environmentObject(statViewModel)
    
    
    var petNameView: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 100))
                .fill(AngularGradient(colors: [.white, .black], center: .topLeading))
                .frame(width: 200, height: 35)
                .shadow(
                    color: .black.opacity(0.3),
                    radius: 10,
                    x:0.0, y:10
                )
            Text("\(PetViewModel().pet.name)")
                .bold()
                .font(.custom("Yoster Island", size: 30))
                .foregroundColor(.black)
                .scaledToFit()
        }
    }
    
    var petImageView: some View {
        Image("\(PetViewModel().pet.image)")
            .resizable()
            .scaledToFit()
            .background(
                AngularGradient(colors: [.white, .black], center: .topLeading)
                    .cornerRadius(20)
                    .shadow(
                        color: .black.opacity(0.5),
                        radius: 10,
                        x: 0.0, y: 5))
    }
    
    var stats: some View {
        VStack {
            statStop
        }
        .foregroundColor(.black)
        .bold()
        .environmentObject(viewModel)
        .frame(width: 350, height: 250)
        .background(
            AngularGradient(colors: [.white, .black], center: .topLeading)
                .cornerRadius(20)
                .shadow(
                    color: .black.opacity(0.5),
                    radius: 10,
                    x: 0.0, y: 5))
    }
    
    var statStop: some View {
        VStack(spacing: 20) {
            StatBar(name: "Thirst", value: 100, color: .blue)
            StatBar(name: "Hunger", value: 100, color: .yellow)
            StatBar(name: "Love", value: 100, color: .red)
            StatBar(name: "Hygiene", value: 100, color: .green)
        }
        .font(.custom("Yoster Island", size: 20))
        .frame(height: 150)
        .padding()
    }
    
    
    var petDescription: some View {
        Text(viewModel.pet.description)
            .foregroundColor(.black)
            .font(.custom("Yoster Island", size: 15))
            .padding(8)
            .multilineTextAlignment(.center)
            .background(
                Color.white
                    .cornerRadius(20)
                    .shadow(
                        color: .black.opacity(0.5),
                        radius: 10,
                        x: 0.0, y: 10))
    }
    
    @State var goHomeBool = false
    
    var goHome: some View {
        Button {
            SoundManager.soundInstance.playSound(sound: .click)
            goHomeBool = true
        } label: {
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: 100, height: 100))
                    .fill(AngularGradient(colors: [ThemeColors.primaryButton, .black], center: .topLeading))
                    .frame(width: 180, height: 35)
                    .shadow(
                        color: .black.opacity(0.5),
                        radius: 10,
                        x:0.0, y:10
                    )
                Text("Lets Go Home!")
                    .font(.custom("Yoster Island", size: 20))
                    .colorInvert()
                    .foregroundColor(.black)
                    .bold()
            }
            .navigate(to: HomeView(DeadPetsVM: DeadPetsVM), when: $goHomeBool)
        }
        
    }
    
    
    struct PopOverView_Previews: PreviewProvider {
        static var previews: some View {
            PopOverView(DeadPetsVM: DeadPetUserDefaults())
                .environmentObject(PetViewModel())
        }
    }
}
