//
//  PopOverView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/23/23.
//

import SwiftUI

struct PopOverView: View {
    @State private var showingPopover = false
    
    @StateObject var viewModel = PetViewModel()
//    var statViewModel = StatsViewModel()
    
    var body: some View {
        VStack {
            Button("You Got A Pet!") {
                showingPopover = true
            }
            .popover(isPresented: $showingPopover) {
                VStack {
                    Spacer()
                    petNameView
                    petImageView
                    Spacer(minLength: 20)
                    petDescription
                    Spacer(minLength: 20)
                    stats
                    Spacer()
                    swipeText
                    
                }
                .environmentObject(viewModel)
                .background(
                    AngularGradient(colors: [.gray, .white], center: .topLeading))
                
            }
        }
        
//        .environmentObject(statViewModel)
    }
    
    var petNameView: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 100))
                .fill(AngularGradient(colors: [.white, .black], center: .topLeading))
                .frame(width: 170, height: 35)
                .shadow(
                    color: .black.opacity(0.3),
                    radius: 10,
                    x:0.0, y:10
                )
                Text("Its A \(PetViewModel().pet.name)!")
                .font(.title)
                .bold()
                .foregroundColor(.black)
        }
    }
    
    var petImageView: some View {
        Image("\(PetViewModel().pet.image)")
            .resizable()
            .frame(width: 200, height: 200)
            .background(
                AngularGradient(colors: [.white, .black], center: .topLeading)
                    .cornerRadius(20)
                    .shadow(
                        color: .black.opacity(0.3),
                        radius: 10,
                        x: 0.0, y: 5))
    }
    
    var stats: some View {
        
//        var statView = StatView()
//            .environmentObject(viewModel)
        
        VStack {
            StatView()
        }
        .environmentObject(viewModel)
        .frame(width: 350, height: 250)
        .background(
            Color.gray
                .cornerRadius(20)
                .shadow(
                    color: .black.opacity(0.7),
                    radius: 10,
                    x: 0.0, y: 10))
    }
    
    var petDescription: some View {
        Text("This pet is quite rare. Only obtain in explicit and illeagal ways. Due to the difficulties, only super rich people tend to take care of them. To be honest, its not a great pet. Super annoying.")
            .frame(width: 320, height: 120)
            .padding(10)
            .multilineTextAlignment(.center)
            .background(
                Color.white
                    .cornerRadius(20)
                    .shadow(
                        color: .black.opacity(0.3),
                        radius: 10,
                        x: 0.0, y: 10))
    }
    var swipeText: some View {
        ZStack {
            Text("Swipe Down")
                .bold()
                .italic()
                .foregroundColor(.white)
        }
    }
}

struct PopOverView_Previews: PreviewProvider {
    static var previews: some View {
        PopOverView()
            .environmentObject(PetViewModel())
    }
}
