//
//  PopOverView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/23/23.
//

import SwiftUI

struct PopOverView: View {
    @State private var showingPopover = false
    
    var viewModel = PetViewModel()
    var statViewModel = StatsViewModel()
    
    var body: some View {
        VStack {
            Button("You Got A Pet!") {
                showingPopover = true
            }
            .popover(isPresented: $showingPopover) {
                VStack {
                    petNameView
                    Spacer()
                    petImageView
                    stats
                    petDescription
                    
                }
            }
        }
    }
    
    var petNameView: some View {
        Text("Its A \(PetViewModel().pet.name)")
            .font(.title)
            .bold()
            .foregroundColor(.mint)
    }
    
    var petImageView: some View {
        Image("brownDog")
            .resizable()
            .frame(width: 200, height: 200)
            .background(
                Color.white
                    .cornerRadius(20)
                    .shadow(
                        color: .black.opacity(0.3),
                        radius: 10,
                        x: 0.0, y: 10))
    }
    
    var stats: some View {
        StatView()
        .background(
            Color.white
                .cornerRadius(20)
                .shadow(
                    color: .black.opacity(0.3),
                    radius: 10,
                    x: 0.0, y: 10))
    }
    
    var petDescription: some View {
        Text("This pet is quite rare. Only obtain in explicit and illeagal ways. Due to the difficulties, only super rich people tend to take care of them. To be honest, its not a great pet. Super annoying.")
    }
}

struct PopOverView_Previews: PreviewProvider {
    static var previews: some View {
        PopOverView()
    }
}
