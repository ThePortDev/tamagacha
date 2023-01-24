//
//  RoomView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/19/23.
//

import SwiftUI
import SpriteKit

struct RoomView: View {
    //@State var activeView: currentView
    @State var isExpanded = false

    @EnvironmentObject var viewModel: PetViewModel
    
    var scene: SKScene {
        let scene = GameScene()
        scene.setup(with: viewModel)
        scene.size = CGSize(width: 400, height: 700)
        scene.scaleMode = .fill
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        return scene
    }

    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                SpriteView(scene: scene)
                    .frame(width: 400, height: UIScreen.main.bounds.height - 100)
                expandedStatView
                    .zIndex(.infinity)
                Button("change scene") {
                    withAnimation {
                        changeScene.toggle()
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height - 100, alignment: .center)
        }
        //.animation(Animation.linear(duration: 1), value: isExpanded)
        //.background(Color.white)
        //.edgesIgnoringSafeArea(.all)
    }
    
    var statView: some View {
        Group {
            if isExpanded {
                expandedStatView
            } else {
                collapsedStatView
                    .padding(.leading, screenWidth - 50)
            }
        }
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }
    }
    
    var expandedStatView: some View {
        StatView()
            .frame(width: screenWidth, height: 230)
            .padding(.top, 100)
            .padding(.bottom, 500)
    }
    
    var collapsedStatView: some View {
        ZStack {
        Rectangle()
            Text("Stats")
                .foregroundColor(Color.red)
        }
        .cornerRadius(20, corners: [.topLeft, .bottomLeft])
        .frame(width: 50, height: 100)
//        .background(Color.blue)
    }
    
    
}

class GameScene: SKScene {
    
    //var food = ["dogFood"]
    //@State var sceneSize:CGSize = CGSize(width: 400, height: 700)
    
//    private var spriteAtlas
    
    override func sceneDidLoad() {
        let background = SKSpriteNode(imageNamed: "cheesepuffs 1")
        background.size = CGSize(width: 500, height: 701)
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
    }
        
    private var currentNode: SKNode?
    
    override func didMove(to view: SKView) {
        let box = SKSpriteNode(imageNamed: "cheesepuffs 1")
        box.size = CGSize(width: 200, height: 150)
        box.position = CGPoint(x: 0.5, y: 0.5)
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 200, height: 150))
        box.name = "pet"
            
        addChild(box)
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -0.5)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {

            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)
            for node in touchedNodes.reversed() {
                if node.name == "pet" {
                    
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
    
    func addDogFood() {
        let dogFood = SKSpriteNode(imageNamed: "dogFood")
        dogFood.size = CGSize(width: 50, height: 100)
        dogFood.position = CGPoint(x: 0.5, y: 0.5)
        dogFood.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 100))
        dogFood.name = "dogFood"

        addChild(dogFood)
    }
}


struct HomeView_Previews3: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
