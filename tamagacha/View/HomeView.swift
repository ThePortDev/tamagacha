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
    //    @State var viewState = CGSize.zero
    
    // settings
    @State var navigateToSettings: Bool = false
    @State var navigateToDeath: Bool = false
    @State var navigateToMiniGame: Bool = false
    @State var navigateToGraveyard: Bool = false
    
    // drag gesture X
    @State private var startingOffsetX: CGFloat = -UIScreen.main.bounds.width
    @State private var currentDragOffsetX: CGFloat = 0
    @State private var endingOffsetX: CGFloat = 0
    
    //drag gesture Y
    @State private var startingOffsetY: CGFloat = UIScreen.main.bounds.height - 46
    @State private var currentDragOffsetY: CGFloat = 0
    @State private var endingOffsetY: CGFloat = 0
    
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
                RoomView(activeView: $activeView)

                StoreView(activeView: $activeView, navigateToSettings: $navigateToSettings, navigateToMiniGame: $navigateToMiniGame, navigateToGraveyard: $navigateToGraveyard)
                    .frame(width: screenWidth, height: 960)
                    .offset(x: (activeView == .left ? screenWidth : 0))
                //                    .offset(y: (activeView == .bottom ? 0 : startingOffsetY))
                    .offset(y: startingOffsetY)
                    .offset(y: currentDragOffsetY)
                    .offset(y: endingOffsetY)
                    .gesture (
                        DragGesture()
                            .onChanged { value in
                                SoundManager.soundInstance.playSound(sound: .swoosh)
                                withAnimation(.spring()) {
                                    if activeView == .bottom && value.translation.height < 0 {
                                        return
                                    } else {
                                        currentDragOffsetY = value.translation.height
                                    }
                                }
                            }
                            .onEnded({ value in
                                withAnimation(.spring()) {
                                    if currentDragOffsetY < -100 {
                                        endingOffsetY = -startingOffsetY - 100
                                        activeView = .bottom
                                    }
                                    else if endingOffsetY != 0 && currentDragOffsetY > 150{
                                        endingOffsetY = 0
                                        activeView = .center
                                    }
                                    currentDragOffsetY = 0
                                }
                            })
                    )
                    .zIndex(.infinity)
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
                    SoundManager.soundInstance.playSound(sound: .hooray)
                    alertToShow = false
                }
                navigateToDeath = !viewModel.pet.isAlive
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


struct GraveyardView: View {
    
    @EnvironmentObject var viewModel: PetViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @StateObject var DeadPetsVM: DeadPetUserDefaults
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(DeadPetsVM.deadPets) { pet in
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
                CoolRect(text: "Go back home", gradientColors: [.blue, .cyan])
            }
        }
    }
}
