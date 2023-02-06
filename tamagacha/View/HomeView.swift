//
//  HomeView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/17/23.
//

import SwiftUI
import SpriteKit

let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height

enum currentView {
    case center
    case bottom
    case top
    case left
    case right
}

struct HomeView: View {
    
    @StateObject var DeadPetsVM: DeadPetUserDefaults
    
    @StateObject var viewModel = PetViewModel()
    
    @State private var welcomeAlert = (title: "Welcome Back!", message: "", isShown: false)
    
    @State var alertToShow: Bool = true
    
    // swipe gesture
    @State var activeView = currentView.center
    @State var wentToStoreFromBathroom = false
    //    @State var viewState = CGSize.zero
    
    // settings
    @State var navigateToSettings: Bool = false
    @State var navigateToDeath: Bool = false
    @State var navigateToMiniGame: Bool = false
    @State var navigateToGraveyard: Bool = false
    
    
    
    //@State var scene: GameScene = GameScene()
    var scene: GameScene {
        let scene = GameScene()
        scene.setup(with: viewModel)
        scene.size = CGSize(width: 400, height: 700)
        scene.scaleMode = .fill
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        return scene
    }
    
    var body: some View {
        VStack(spacing: 0) {
            //            Rectangle()
            //                .foregroundColor(.blue)
            //                .ignoresSafeArea()
            //                .frame(height: 10)
            ZStack {
                RoomView(activeView: $activeView, wentToStoreFromBathroom: $wentToStoreFromBathroom)

                StoreView(activeView: $activeView, wentToStoreFromBathroom: $wentToStoreFromBathroom, navigateToSettings: $navigateToSettings, navigateToMiniGame: $navigateToMiniGame, navigateToGraveyard: $navigateToGraveyard)
                    .offset(y: (activeView != .bottom ? screenHeight - 150 : -screenHeight / 4))
            }
            .navigate(to: SettingsView().environmentObject(viewModel), when: $navigateToSettings)
            .navigate(to: DeathScreenPopOverView(DeadPetsVM: DeadPetsVM).environmentObject(viewModel), when: $navigateToDeath)
            .navigate(to: GraveyardView(DeadPetsVM: DeadPetsVM).environmentObject(viewModel), when: $navigateToGraveyard)
            .navigate(to: MiniGameView(), when: $navigateToMiniGame)
            .environmentObject(viewModel)
            .onAppear {
                if alertToShow == true {
                    welcomeAlert.message = viewModel.pet.petStatus
                    welcomeAlert.isShown = true
                    SoundManager.soundInstance.playSound(sound: .notif)
                    alertToShow = false
                }
                
                viewModel.onDeath = {
                    self.navigateToDeath = true
                }
            }
            .alert(welcomeAlert.title, isPresented: $welcomeAlert.isShown) {
                Button("Cool!") {
                    SoundManager.soundInstance.playSound(sound: .click)
                    welcomeAlert.isShown = false
                }
            } message: {
                Text(welcomeAlert.message)
            }
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(DeadPetsVM: DeadPetUserDefaults())
    }
}



enum Defaults {
    static var textColor = Color.black
}
