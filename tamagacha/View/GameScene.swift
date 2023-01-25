//
//  GameScene.swift
//  tamagacha
//
//  Created by Porter Dover on 1/25/23.
//

import SwiftUI
import SpriteKit

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
