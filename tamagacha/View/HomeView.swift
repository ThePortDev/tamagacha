//
//  HomeView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/17/23.
//

import SwiftUI
import SpriteKit

enum currentView {
    case center
    case bottom
    case left
}

let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height


struct HomeView: View {
    
    @State var activeView = currentView.center
    @State var viewState = CGSize.zero
    
    @State var navigateToSettings: Bool = false
    @State var navigateToToychest: Bool = false
    @State var navigateToKitchen: Bool = false

    
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 400, height: 700)
        scene.scaleMode = .fill
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        return scene
    }
    
    @State private var showWelcomeMessage = true
    
    var body: some View {
        VStack {
            ZStack {
                RoomView(activeView: self.activeView)
                StoreView(activeView: self.$activeView, navigateToSettings: $navigateToSettings, navigateToToyChest: $navigateToToychest, navigateToKitchen: $navigateToKitchen)
                    .offset(y: self.activeView == currentView.bottom ? 0 : screenHeight * 0.85)
                BathroomView(activeView: self.activeView)
                    .offset(x: self.activeView == currentView.left ? 0 : -screenWidth)
            }
            .gesture(
                (self.activeView == currentView.center) ?
                
                DragGesture().onChanged { value in
                    self.viewState = value.translation
                }
                    .onEnded { value in
                        if value.predictedEndTranslation.height < -screenHeight / 2 {
                            withAnimation(.easeInOut) {
                                self.activeView = currentView.bottom
                                self.viewState = .zero
                            }
                        }
                        else if value.predictedEndTranslation.width > screenWidth * 2 {
                            withAnimation(.easeInOut) {
                                self.activeView = currentView.left
                                self.viewState = .zero
                            }
                        }
                        else {
                            self.viewState = .zero
                        }
                    }
                : DragGesture().onChanged { value in
                    switch self.activeView {
                        case.left:
                            guard value.translation.width < 1 else { return }
                            self.viewState = value.translation
                        case.bottom:
                            guard value.translation.height < 1 else { return }
                            self.viewState = value.translation
                        case.center:
                            self.viewState = value.translation
                    }
                }
                    .onEnded { value in
                        switch self.activeView {
                            case.left:
                                if value.predictedEndTranslation.width < -screenWidth / 2 {
                                    withAnimation(.easeInOut) {
                                        self.activeView = .center
                                        self.viewState = .zero
                                    }
                                }
                                else {
                                    self.viewState = .zero
                                }
                            case.bottom:
                                if value.predictedEndTranslation.height > screenHeight / 2 {
                                    withAnimation(.easeInOut) {
                                        self.activeView = .center
                                        self.viewState = .zero
                                    }
                                } else {
                                    self.viewState = .zero
                                }
                            case .center:
                                self.viewState = .zero
                        }
                    }
            )
        }
        .navigate(to: SettingsView(), when: $navigateToSettings)
        .navigate(to: ToychestView(), when: $navigateToToychest)
        .navigate(to: KitchenView(), when: $navigateToKitchen)
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

class GameScene: SKScene {
    
    //@State var sceneSize:CGSize = CGSize(width: 400, height: 700)
    
//    private var spriteAtlas
    
    override func sceneDidLoad() {

        backgroundColor = .white
        
        let box = SKSpriteNode(imageNamed: "cheesepuffs")
        box.position = CGPoint(x: 0.5, y: 0.5)
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 200, height: 150))
        box.name = "draggable"
            
        addChild(box)
        
    }
        
    private var currentNode: SKNode?
    
    override func didMove(to view: SKView) {
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
            if touchLocation.y < -350 || touchLocation.y > 350 {
                return
            } else {
                //self.sceneSize = CGSize(width: 700, height: 400)
                node.position = touchLocation
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
