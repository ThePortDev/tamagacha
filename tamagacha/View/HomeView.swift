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
    

    @StateObject var viewModel = PetViewModel()

    
    // swipe gesture
    @State var activeView = currentView.center
//    @State var viewState = CGSize.zero
    
    // settings
    @State var navigateToSettings: Bool = false
    
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
                RoomView(viewModel: viewModel, scene: scene)
                StoreView(activeView: $activeView, navigateToSettings: $navigateToSettings)
                    .frame(width: screenWidth, height: 960)
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
                BathroomView(activeView: $activeView)
                    .frame(width: 470, height: 800)
                    .offset(x: startingOffsetX)
                    .offset(x: currentDragOffsetX)
                    .offset(x: endingOffsetX)
                    .gesture (
                        DragGesture()
                            .onChanged { value in
                                withAnimation(.spring()) {
                                    if activeView == .left && value.translation.width > 0 {
                                        return
                                    } else {
                                        currentDragOffsetX = value.translation.width
                                    }
                                }
                            }
                            .onEnded({ value in
                                withAnimation(.spring()) {
                                    if currentDragOffsetX > 100 {
                                        endingOffsetX = -startingOffsetX + 20
                                        activeView = .left
                                        //changeScene = true
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
            .navigate(to: SettingsView(), when: $navigateToSettings)
            .environmentObject(viewModel)
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


class GameScene: SKScene {
    
    var viewModel: PetViewModel!
    //@State var sceneSize:CGSize = CGSize(width: 400, height: 700)
    
//    private var spriteAtlas
    
    func setup(with viewModel: PetViewModel) {
        self.viewModel = viewModel
    }
    
    override func sceneDidLoad() {
        let background = SKSpriteNode(imageNamed: "living")
        background.size = CGSize(width: 500, height: 701)
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
    }
        
    private var currentNode: SKNode?
    
    override func didMove(to view: SKView) {
        let box = viewModel.getPetType()
        box.size = CGSize(width: 200, height: 150)
        box.position = CGPoint(x: 0.5, y: 0.5)
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 200, height: 150))
        box.name = "draggable"
            
        addChild(box)
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -0.5)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {

            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes.reversed() {
                if node.name == "draggable" {
                    if viewModel.pet.isAlive {
                        viewModel.petPet(amount: 10)
                    }
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
                //print("\(touchLocation)")
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
