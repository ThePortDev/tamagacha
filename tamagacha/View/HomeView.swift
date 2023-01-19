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
    
    // swipe gesture
    @State var activeView = currentView.center
//    @State var viewState = CGSize.zero
    
    // navbar
    @State var navigateToSettings: Bool = false
    @State var navigateToToychest: Bool = false
    @State var navigateToKitchen: Bool = false
    
    // drag gesture X
    @State private var startingOffsetX: CGFloat = -UIScreen.main.bounds.width
    @State private var currentDragOffsetX: CGFloat = 0
    @State private var endingOffsetX: CGFloat = 0
    
    //drag gesture Y
    @State private var startingOffsetY: CGFloat = UIScreen.main.bounds.height - 125
    @State private var currentDragOffsetY: CGFloat = 0
    @State private var endingOffsetY: CGFloat = 0

    
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
            Text("\(currentDragOffsetY)")
            ZStack {
                RoomView()
                StoreView(activeView: $activeView, navigateToSettings: $navigateToSettings, navigateToToyChest: $navigateToToychest, navigateToKitchen: $navigateToKitchen)
                    .offset(y: startingOffsetY)
                    .offset(y: currentDragOffsetY)
                    .offset(y: endingOffsetY)
                    .gesture (
                        DragGesture()
                            .onChanged { value in
                                withAnimation(.spring()) {
                                    currentDragOffsetY = value.translation.height
                                }
                            }
                            .onEnded({ value in
                                withAnimation(.spring()) {
                                    if currentDragOffsetY < -100 {
                                        endingOffsetY = -startingOffsetY
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
                BathroomView(activeView: $activeView)
                    .frame(width: 450, height: 800)
                    .offset(x: startingOffsetX)
                    .offset(x: currentDragOffsetX)
                    .offset(x: endingOffsetX)
                    .gesture (
                        DragGesture()
                            .onChanged { value in
                                withAnimation(.spring()) {
                                    currentDragOffsetX = value.translation.width
                                }
                            }
                            .onEnded({ value in
                                withAnimation(.spring()) {
                                    if currentDragOffsetX > 100 {
                                        endingOffsetX = -startingOffsetX + 20
                                        activeView = .left
                                    }
                                    else if endingOffsetX != 0 && currentDragOffsetX < -150{
                                        endingOffsetX = 0
                                        activeView = .center
                                    }
                                    currentDragOffsetX = 0
                                }
                            })
                    )
            }
//            .gesture(
//                (self.activeView == currentView.center) ?
//
//                DragGesture().onChanged { value in
//                    self.viewState = value.translation
//                }
//                    .onEnded { value in
//                        if value.predictedEndTranslation.height < -screenHeight / 2 {
//                            withAnimation(.easeInOut) {
//                                self.activeView = currentView.bottom
//                                self.viewState = .zero
//                            }
//                        }
//                        else if value.predictedEndTranslation.width > screenWidth * 2 {
//                            withAnimation(.easeInOut) {
//                                self.activeView = currentView.left
//                                self.viewState = .zero
//                            }
//                        }
//                        else {
//                            self.viewState = .zero
//                        }
//                    }
//                : DragGesture().onChanged { value in
//                    switch self.activeView {
//                        case.left:
//                            guard value.translation.width < 1 else { return }
//                            self.viewState = value.translation
//                        case.bottom:
//                            guard value.translation.height < 1 else { return }
//                            self.viewState = value.translation
//                        case.center:
//                            self.viewState = value.translation
//                    }
//                }
//                    .onEnded { value in
//                        switch self.activeView {
//                            case.left:
//                                if value.predictedEndTranslation.width < -screenWidth / 2 {
//                                    withAnimation(.easeInOut) {
//                                        self.activeView = .center
//                                        self.viewState = .zero
//                                    }
//                                }
//                                else {
//                                    self.viewState = .zero
//                                }
//                            case.bottom:
//                                if value.predictedEndTranslation.height > screenHeight / 2 {
//                                    withAnimation(.easeInOut) {
//                                        self.activeView = .center
//                                        self.viewState = .zero
//                                    }
//                                } else {
//                                    self.viewState = .zero
//                                }
//                            case .center:
//                                self.viewState = .zero
//                        }
//                    }
//            )
//
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
