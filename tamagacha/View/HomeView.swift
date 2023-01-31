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
    
    @StateObject var viewModel = PetViewModel()
    
    
    
    // swipe gesture
    @State var activeView = currentView.center
    //    @State var viewState = CGSize.zero
    
    // settings
    @State var navigateToSettings: Bool = false
    @State var navigateToDeath: Bool = false
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
    
    @State private var showWelcomeMessage = true
    
    var body: some View {
        VStack(spacing: 0) {
            //            Rectangle()
            //                .foregroundColor(.blue)
            //                .ignoresSafeArea()
            //                .frame(height: 10)
            ZStack {
                RoomView(activeView: $activeView)
                    StoreView(activeView: $activeView, navigateToSettings: $navigateToSettings)
                    .frame(width: screenWidth, height: 960)
                    .offset(x: (activeView == .left ? screenWidth : 0))
                    .offset(y: startingOffsetY)
                    .offset(y: currentDragOffsetY)
                    .offset(y: endingOffsetY)
                    .gesture (
                        DragGesture()
                            .onChanged { value in
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
                
//                BathroomView(activeView: $activeView)
//                    .frame(width: 470, height: 800)
//                    .offset(x: startingOffsetX)
//                    .offset(x: currentDragOffsetX)
//                    .offset(x: endingOffsetX)
//                    .gesture (
//                        DragGesture()
//                            .onChanged { value in
//                                withAnimation(.spring()) {
//                                    if activeView == .left && value.translation.width > 0 {
//                                        return
//                                    } else {
//                                        currentDragOffsetX = value.translation.width
//                                    }
//                                }
//                            }
//                            .onEnded({ value in
//                                withAnimation(.spring()) {
//                                    if currentDragOffsetX > 100 {
//                                        endingOffsetX = -startingOffsetX + 20
//                                        activeView = .left
//                                        //changeScene = true
//                                    }
//                                    else if endingOffsetX != 0 && currentDragOffsetX < -150 {
//                                        endingOffsetX = 0
//                                        activeView = .center
//                                    }
//                                    currentDragOffsetX = 0
//                                }
//                            })
//                    )
            }
            .navigate(to: SettingsView().environmentObject(viewModel), when: $navigateToSettings)
            .navigate(to: DeathScreenPopOverView().environmentObject(viewModel), when: $navigateToDeath)
            .navigate(to: GraveyardView().environmentObject(viewModel), when: $navigateToGraveyard)
            .environmentObject(viewModel)
            .onAppear {
                navigateToDeath = !viewModel.pet.isAlive
            }
        }
    }
    
    
    
    var welcomeMessage: some View {
        Group {
            if showWelcomeMessage {
                Text("Welcome Home!")
                    .font(.title)
            }
        }
    }
    
    
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct GraveyardView: View {
    
    @EnvironmentObject var viewModel: PetViewModel
    
    var body: some View {
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
    }
}
