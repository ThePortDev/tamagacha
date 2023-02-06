//
//  GraveyardView.swift
//  tamagacha
//
//  Created by Hafa Bonati on 2/6/23.
//

import Foundation

import SwiftUI

struct GraveyardView: View {
    
    @EnvironmentObject var viewModel: PetViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var DeadPetsVM: DeadPetUserDefaults
    
    var testArray = [
        Pet(name: "Steve", image: "TESTBIRD", petType: .dog, maxHunger: 100, hunger: 100, maxThirst: 100, thirst: 100, maxHygiene: 100, hygiene: 100, maxLove: 100, love: 100, description: "This pet is quite rare. Only obtain in explicit and illegal ways. Due to the difficulties, only super rich people tend to take care of them. To be honest, its not a great pet. Super annoying."),
        Pet(name: "Other Steve", image: "TESTBIRD", petType: .dog, maxHunger: 100, hunger: 100, maxThirst: 100, thirst: 100, maxHygiene: 100, hygiene: 100, maxLove: 100, love: 100, description: "This pet is quite rare. Only obtain in explicit and illegal ways. Due to the difficulties, only super rich people tend to take care of them. To be honest, its not a great pet. Super annoying.")
    ]
    
    var body: some View {
        VStack {
            graveTitle
            Spacer(minLength: 30)
            scrollDeadPets
            deadButton
            Spacer()
        }
        .background(
            Image("cemetary")
                .resizable()
                .frame(width: 400,height: 880)
        )
    }
    
    var graveTitle: some View {
        Text("GraveYard")
            .font(.custom("HangTheDJ", size: 40))
    }
    
    var deadButton: some View {
        Button() {
            SoundManager.soundInstance.playSound(sound: .click)
            dismiss()
        } label: {
                Text("Go Back Home?")
                    .font(.custom("HangTheDJ", size: 35))
                    .colorInvert()
                    .foregroundColor(.black)
                    .bold()
                    .italic()
                    .background(
                        RoundedRectangle(cornerSize: CGSize(width: 100, height: 100))
                            .fill(AngularGradient(colors: [.blue, .white], center: .topLeading))
                            .frame(width: 325, height: 55)
                            .shadow(
                                color: .black.opacity(0.5),
                                radius: 10,
                                x:0.0, y:10
                            )
                    )
        }
    }
    
    var scrollDeadPets: some View {
        ScrollView {
            ForEach(DeadPetsVM.deadPets) { pet in
                ZStack {
                    HStack {
                        Image(pet.image)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .background(
                                AngularGradient(colors: [.white, .black], center: .topLeading)
                                    .cornerRadius(20)
                                    .shadow(
                                        color: .black.opacity(0.5),
                                        radius: 10,
                                        x: 0.0, y: 5))
                        Text(pet.description)
                            .font(.custom("HangTheDJ", size: 15))
                            .foregroundColor(.black)
                            .frame(width: 270, height: 140)
                            .background(
                                AngularGradient(colors: [.yellow, .black], center: .topLeading)
                                    .cornerRadius(20)
                                    .shadow(
                                        color: .black.opacity(0.5),
                                        radius: 10,
                                        x: 0.0, y: 5)
                            )
                    }
                }
            }
        }
    }
        
    
    struct GraveyardView_Previews: PreviewProvider {
        static var previews: some View {
            GraveyardView(DeadPetsVM: DeadPetUserDefaults())
                .environmentObject(PetViewModel())
        }
    }
}
