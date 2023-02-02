//
//  TabBar.swift
//  tamagacha
//
//  Created by Porter Dover on 1/25/23.
//

import SwiftUI

struct CustomTabBar: View {
    
    @EnvironmentObject var viewModel: PetViewModel
    
    @Binding var activeView: currentView
    
    @Binding var selectedTab: String
    @Binding var navigateToSettings: Bool
    @Binding var navigateToMiniGame: Bool
    @Binding var navigateToGraveyard: Bool
        
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .frame(width: screenWidth, height: 900)
                .foregroundColor(.blue)
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    HStack(spacing: 0) {
                        TabBarButton(activeView: $activeView, image: "house", selectedTab: $selectedTab)
                        TabBarButton(activeView: $activeView, image: "bookmark", selectedTab: $selectedTab)
                        //TabBarButton(image: "message", selectedTab: $selectedTab)
                        TabBarButton(activeView: $activeView,image: "sportscourt", selectedTab: $selectedTab)
                        SettingsButton(activeView: $activeView, image: "gearshape", navigateToSettings: $navigateToSettings)
                        MiniGameButton(activeView: $activeView, image: "1.circle", navigateToMiniGame: $navigateToMiniGame)
                        GraveyardButton(image: "🪦", navigateToGraveyard: $navigateToGraveyard)

                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30, corners: [.topRight, .topLeft])
                    .padding(.horizontal)
                    .padding(.top, 100)
                }
                Text("Money: $\(viewModel.store.money)")
                testView
            }
        }
    }
    
    var testView: some View {
        ZStack {
            if selectedTab == "house" {
                VStack {
                    Text("Food")
                    DisplayStoreProduct(productType: .food)
                }
            }
            else if selectedTab == "bookmark" {
                VStack {
                    Text("Beverages")
                    DisplayStoreProduct(productType: .beverage)
                }
                
            }
            else if selectedTab == "message" {
                VStack {
                    Text("Accessories")
                    DisplayStoreProduct(productType: .accessory)
                }
            }
            else if selectedTab == "sportscourt" {
                    VStack {
                        Text("Toys")
                        DisplayStoreProduct(productType: .toy)
                    }
            }
        }
    }
}

struct DisplayStoreProduct: View {
    
    @EnvironmentObject var viewModel: PetViewModel
    
    @State var productType: Item.types
    
    
    var body: some View {
        HStack {
            ForEach(viewModel.store.products, id: \.self) { item in
                if productType == item.type {
                    SubView(withItem: item)
                }
            }
        }
    }
}

struct SubView: View {
    @EnvironmentObject var viewModel: PetViewModel

    var withItem: Item
    
    var body: some View {
        GeometryReader { geometry in
            Button {
                SoundManager.soundInstance.playSound(sound: .click)
                viewModel.store.buy(item: withItem)
                viewModel.saveData()
                print("You have bought \(withItem.name)!")
            } label: {
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.red)
                    .frame(width: 100, height: 100)
                VStack {
                    Text(withItem.name)
                    Text("+ \(Int(withItem.improveStatsBy))")
                    Text("Price: $\(withItem.price)")
                }
            }
        }
        }
    }
}

struct TabBarButton: View {
    
    @Binding var activeView: currentView
    
    var image: String
    @Binding var selectedTab: String
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                SoundManager.soundInstance.playSound(sound: .click)
                withAnimation {
                    selectedTab = image
                }
                
            }) {
                Image(systemName: "\(image)\(selectedTab == image ? ".fill" : "")")
                    .font(.system(size: 25, weight: .semibold))
                    .offset(y: selectedTab == image ? -10 : 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 50)
    }
}

struct SettingsButton: View {
    
    @Binding var activeView: currentView

    var image: String
    @Binding var navigateToSettings: Bool
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                SoundManager.soundInstance.playSound(sound: .click)
                navigateToSettings = true
            }) {
                Image(systemName: "\(image)")
                    .font(.system(size: 25, weight: .semibold))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 50)
    }
}

struct MiniGameButton: View {
    
    @Binding var activeView: currentView

    var image: String
    @Binding var navigateToMiniGame: Bool
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                navigateToMiniGame = true
            }) {
                Image(systemName: "\(image)")
                    .font(.system(size: 25, weight: .semibold))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 50)
    }
}

struct GraveyardButton: View {
    var image: String
    @Binding var navigateToGraveyard: Bool
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                SoundManager.soundInstance.playSound(sound: .click)
                navigateToGraveyard = true
            }) {
                Text(image)
                    .font(.system(size: 25, weight: .semibold))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 50)
    }
}


struct HomeView4_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct MiniGameView: View {
    
    @EnvironmentObject var viewModel: PetViewModel
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Button {
                dismiss()
            } label: {
                Text("Back")
            }
            
//            SpriteView(scene: viewModel.catchMiniGameScene)
//                .frame(width: screenWidth, height: screenHeight)
//                .ignoresSafeArea()
            
        }
    }
}

import SpriteKit

class CatchMiniGameScene: SKScene {
    
    var viewModel: PetViewModel!
    
    func setup(with viewModel: PetViewModel) {
        self.viewModel = viewModel
    }
    
    private var currentNode: SKNode?
    
    var draggablePet: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "tennisBall")
        background.anchorPoint = CGPoint.zero
        //background.position = CGPoint.zero
        addChild(background)
        
        draggablePet = SKSpriteNode(imageNamed: viewModel.pet.image)
        draggablePet!.position = CGPoint(x: size.width / 2, y: size.height / 2)
        draggablePet!.size = CGSize(width: 50, height: 50)
        draggablePet!.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        draggablePet!.name = "draggable"
        draggablePet!.physicsBody?.categoryBitMask = 0b001
        addChild(draggablePet!)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -0.5)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {

            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes.reversed() {
                if node.name == "draggable" {
                    self.currentNode = node
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: self)
                //self.sceneSize = CGSize(width: 700, height: 400)
                node.position = touchLocation
                //print("\(touchLocation)")
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
}
