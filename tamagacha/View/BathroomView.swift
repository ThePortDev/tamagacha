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
                viewModel.goToShower()
                showerButtonShowing = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
                    showerButtonShowing = true
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: Constants.showerButtonCornerRadius)
                        .frame(width: Constants.showerButtonFrameWidth, height: Constants.showerButtonFrameHeight)
                    Text("Shower")
                        .foregroundColor(Constants.showerButtonFontColor)
                        .font(Constants.showerButtonFont)
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
                        Rectangle().cornerRadius(Constants.bathroomButtonCornerRadius, corners: [.topLeft, .bottomLeft])
                        Text("Back")
                            .foregroundColor(Constants.bathroomBackButtonForegroundColor)
                            .font(Constants.bathroomBackButtonFont)
                            .rotationEffect(Angle(degrees: 90))
                    }
                    ZStack {
                        Rectangle().cornerRadius(Constants.bathroomButtonCornerRadius, corners: [.topRight, .bottomRight])
                        Text("🛀")
                    }
                }
            }
            .frame(width: Constants.bathroomButtonFrameWidth, height: Constants.bathroomButtonFrameHeight)
            .padding(.leading, screenWidth)


            
        }
        
    }
}

struct HomeView3_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(DeadPetsVM: DeadPetUserDefaults())
    }
}
