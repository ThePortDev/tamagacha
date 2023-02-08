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

struct Constants {
    
    // Pet Sprite
    static let petSpriteSize: CGSize = CGSize(width: 200, height: 200)
    static let petNameFontSize: CGFloat = 20
    static let petNameFontName: String = "Yoster Island"
    static let petNameFontColor: UIColor = .white
    
    // Item Sprite
    static let itemSpriteSize: CGSize = CGSize(width: 50, height: 100)
    
    // GameScene scene
    static let centerOfFirstSceneX: CGFloat = screenWidth * 0.25
    static let centerOfSecondSceneX: CGFloat = -screenWidth * 0.75
    static let centerOfFirstScene: CGPoint = CGPoint(x: centerOfFirstSceneX, y: screenHeight / 2)
    static let scenePhysicsBody: CGPath = CGPath(rect: CGRect(x: -screenWidth, y: 90, width: screenWidth * 2, height: screenHeight), transform: nil)
    static let sceneGravity: CGVector = CGVector(dx: 0, dy: -0.3)
    
    // Store
    static let collapsedStoreYOffset: CGFloat = screenHeight - 150
    static let expandedStoreYOffset: CGFloat = -screenHeight / 4
    
    // store font
    static let storeMoneyFont: Font = .custom("HangTheDj", size: 20)
    
    // store Items/products
    static let storeItemsFrameWidth: CGFloat = screenWidth - 50
    static let storeItemsFrameHeight: CGFloat = 100
    static let storeItemsFont: Font = .custom("Yoster Island", size: 15)

    // Tabs
    static let collapsedTabsYOffset: CGFloat = 0
    static let expandedTabsYOffset: CGFloat = 200
    static let tabsBackgroundColor: Color = .white
    static let tabsCornerRadius: CGFloat = 30
    static let tabButtonsFrameHeight: CGFloat = 100
    
    // Inventory
    static let collapsedInventoryYOffset: CGFloat = -screenHeight + 100
    static let expandedInventoryYOffset: CGFloat = -50
    static let inventoryFrameWidth: CGFloat = 100
    static let inventoryFrameHeight: CGFloat = screenHeight
    static let inventoryCornerRadius: CGFloat = 10
    static let inventoryForegroundColor: Color = .orange
    
    // StatView
    static let statsFrameWidth: CGFloat = screenWidth
    static let statsFrameHeight: CGFloat = 230
    
    // BathroomView
    // shower button
    static let showerButtonCornerRadius: CGFloat = 15
    static let showerButtonFrameWidth: CGFloat = 100
    static let showerButtonFrameHeight: CGFloat = 50
    static let showerButtonFont: Font = .custom("Yoster Island", size: 18)
    static let showerButtonFontColor: Color = .white
    
    // bathroom button
    static let bathroomButtonCornerRadius: CGFloat = 20
    static let bathroomBackButtonForegroundColor: Color = .white
    static let bathroomBackButtonFont: Font = .custom("Yoster Island", size: 18)
    static let bathroomButtonFrameWidth: CGFloat = 80
    static let bathroomButtonFrameHeight: CGFloat = 80
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
        scene.size = CGSize(width: screenWidth, height: screenHeight)
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
                    .offset(y: (activeView != .bottom ? Constants.collapsedStoreYOffset : Constants.expandedStoreYOffset))
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
