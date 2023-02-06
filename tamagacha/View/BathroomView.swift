//
//  BathroomView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/19/23.
//

import SwiftUI

struct BathroomView: View {
    @Binding var activeView: currentView
    @EnvironmentObject var viewModel: PetViewModel
    @State var trailingPadding = 0
    @State var showerButtonShowing = true
    
    
    var body: some View {
        ZStack {
            Button {
                SoundManager.soundInstance.playSound(sound: .shower)
                viewModel.shower(amount: 10)
                showerButtonShowing = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
                    showerButtonShowing = true
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 100, height: 50)
                    Text("Shower")
                        .foregroundColor(.white)
                }
            }.disabled(!showerButtonShowing)


            .padding(.bottom, 100)
            Button {
                switch activeView {
                    case .center:
                    withAnimation(.linear(duration: 1)) {
                        activeView = .left
                    }
                    case .left:
                    withAnimation(.linear(duration: 1)) {
                        activeView = .center
                    }
                    default:
                    withAnimation(.linear(duration: 1)) {
                        activeView = .center
                    }
                }
                SoundManager.soundInstance.playSound(sound: .click)
                viewModel.gameScene.moveScene()
            } label: {
                HStack(spacing: 0) {
                    ZStack {
                        Rectangle().cornerRadius(20, corners: [.topLeft, .bottomLeft])
                        Text("Back")
                            .foregroundColor(.black)
                            .rotationEffect(Angle(degrees: 90))
                    }
                    ZStack {
                        Rectangle().cornerRadius(20, corners: [.topRight, .bottomRight])
                        Text("🛀")
                    }
                }
            }
            .frame(width: 80, height: 80)
            .padding(.leading, screenWidth)


            
        }
        
    }
}

struct HomeView3_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(DeadPetsVM: DeadPetUserDefaults())
    }
}
