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
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(viewModel.pet.deadPets) { pet in
                    VStack {
                        Image("TOMBTEST")
                            .resizable()
                            .frame(width: 300, height: 300)
                            .background(
                                AngularGradient(colors: [.white, .black], center: .topLeading)
                                    .cornerRadius(20)
                                    .shadow(
                                        color: .black.opacity(0.5),
                                        radius: 10,
                                        x: 0.0, y: 5))
                        Image(pet.image)
                        Text("Here lies: \(pet.name)")
                    }
                }
            }
            Button() {
                SoundManager.soundInstance.playSound(sound: .click)
                dismiss()
            } label: {
                CoolRect(text: "Go back home", gradientColors: [.blue, .white])
            }
        }
        .background(
            Image("cemetary")
                .resizable()
                .frame(width: 400,height: 880)
        )
    }
        
    
    struct GraveyardView_Previews: PreviewProvider {
        static var previews: some View {
            GraveyardView()
                .environmentObject(PetViewModel())
        }
    }
}
