//
//  GameScene.swift
//  tamagacha
//
//  Created by Porter Dover on 1/25/23.
//

import SwiftUI
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var viewModel: PetViewModel!
    //@State var sceneSize:CGSize = CGSize(width: 400, height: 700)
    
//    private var spriteAtlas
    
    func setup(with viewModel: PetViewModel) {
        self.viewModel = viewModel
    }

        
    private var currentNode: SKNode?
    
    var cam: SKCameraNode!
    var firstScene = true
    
    var isShowering = false
    
    var box: SKSpriteNode?
    var boxName: SKLabelNode?
    var moveBox: SKNode?
        
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "livingroom")
        background.anchorPoint = CGPoint.zero
        background.position = CGPoint(x: -screenWidth / 4, y: 0)
        background.size = CGSize(width: screenWidth, height: screenHeight)
        //background.zPosition = -1
        addChild(background)
        
        let bathroomBackground = SKSpriteNode(imageNamed: "bathroom")
        bathroomBackground.anchorPoint = CGPoint(x: 1, y: 0)
        bathroomBackground.position = CGPoint(x: -100, y: 0)
        bathroomBackground.size = CGSize(width: screenWidth, height: screenHeight)
        //background.zPosition = -1
        addChild(bathroomBackground)
        
        //physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        

        box = SKSpriteNode(imageNamed: viewModel.pet.image)
        box!.position = Constants.centerOfFirstScene
        box!.size = Constants.petSpriteSize
        box!.physicsBody = SKPhysicsBody(rectangleOf: Constants.petSpriteSize)
        box!.name = "draggable"
        box!.physicsBody?.categoryBitMask = 0b001
        addChild(box!)

        boxName = SKLabelNode(text: "\(viewModel.pet.name) - \(viewModel.pet.age)")
        boxName?.fontName = Constants.petNameFontName
        boxName?.fontSize = Constants.petNameFontSize
        boxName?.fontColor = Constants.petNameFontColor
        addChild(boxName!)
        
        moveBox = SKNode()//SKSpriteNode(color: .red, size: CGSize(width: 5, height: 5))
        moveBox!.position = CGPoint(x: screenWidth * 0.25, y: 0.5)
        //moveBox!.size = CGSize(width: 5, height: 5)
        //moveBox!.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 5, height: 5))
        addChild(moveBox!)
                
        cam = SKCameraNode()
        cam.zPosition = 10
        cam.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(cam)
        camera = cam

//        physicsBody = SKPhysicsBody(edgeLoopFrom: CGPath(rect: CGRect(x: -screenWidth - 100, y: 100, width: screenWidth * 2, height: screenHeight-100), transform: nil))
        physicsBody = SKPhysicsBody(edgeChainFrom: Constants.scenePhysicsBody)
        
        physicsWorld.contactDelegate = self
        
        self.physicsWorld.gravity = Constants.sceneGravity
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let location = touch.location(in: self)
            let touchedNodes = self.nodes(at: location)
            
            // Pet moves to your tap
//            box!.run(SKAction.moveTo(x: location.x, duration: 1))
//            box!.run(SKAction.moveTo(y: location.y, duration: 1))
            
            // Drag Pet
            for node in touchedNodes.reversed() {
                if node.name == "draggable" /*|| Item(name: node.name!).type == .toy*/ {
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
            if touchLocation.y < Constants.scenePhysicsBody.boundingBox.minY || touchLocation.y > Constants.scenePhysicsBody.boundingBox.height - Constants.petSpriteSize.height {
                return
            } else {
                if  firstScene && touchLocation.x > screenWidth - Constants.petSpriteSize.width * 0.75 || firstScene && touchLocation.x < -Constants.petSpriteSize.width * 0.75{
                    return
                } else if !firstScene && touchLocation.x > -150 || !firstScene && touchLocation.x < -screenWidth - 50 {
                    return
                } else {
                    node.position = touchLocation
                }
                //}
                //print("\(touchLocation)")
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        switch viewModel.pet.petType {
            case .bird :
                SoundManager.soundInstance.playSound(sound: .chirp)
            case .dog :
                SoundManager.soundInstance.playSound(sound: .woof)
            case .fish :
                SoundManager.soundInstance.playSound(sound: .blub)
            case .cat :
                SoundManager.soundInstance.playSound(sound: .meow)
            case .slime :
                SoundManager.soundInstance.playSound(sound: .jiggle)
        }
        if !(box!.hasActions()) {
            let flip = SKAction.scaleX(to: box!.xScale * -1, duration: 1)
            let flip2 = SKAction.scaleX(to: box!.xScale, duration: 1)
            let action = SKAction.sequence([flip, flip2])
            action.timingMode = .easeOut
            box?.run(action)
        }
        self.currentNode = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.currentNode = nil
    }
    
    override func update(_ currentTime: TimeInterval) {
        cam.position.x = moveBox!.position.x
        boxName!.position = CGPoint(x: box!.position.x, y: CGFloat((box?.position.y)!) + box!.size.height / 2)
        boxName?.text = "\(viewModel.pet.name) - \(viewModel.pet.age / 86400) Day\(((viewModel.pet.age / 86400) > 1) ? "" : "s")"
        
        if isShowering {
            
            
            let activeObjects = children.compactMap { $0 as? WaterDrop}
            if activeObjects.count < 500 {
                addChild(WaterDrop(startPosition: CGPoint(x: CGFloat.random(in: (-screenWidth / 2 - 20)...(-screenWidth / 2 + 20)), y: 700)))
            }
        }
        for child in children {
            if child.name == "waterDrop" {
                if child.frame.maxY < 500 {
                    child.removeFromParent()
                }
            }
        }
        
    }
    
    func collisionBetween(ball: SKNode, object: SKNode) {
        if "\(Item(name: ball.name!).type)" == "food" && object.name == "draggable" {
            destroy(ball: ball)
            viewModel.feed(amount: Item(name: ball.name!).improveStatsBy)
        } else if "\(Item(name: ball.name!).type)" == "beverage" && object.name == "draggable" {
            destroy(ball: ball)
            viewModel.giveWater(amount: Item(name: ball.name!).improveStatsBy)
        }
    }

    func destroy(ball: SKNode) {
        ball.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if "\(Item(name: (contact.bodyA.node?.name) ?? "").type)" == "food" {
            collisionBetween(ball: contact.bodyA.node!, object: contact.bodyB.node!)
        } else if "\(Item(name: (contact.bodyB.node?.name) ?? "").type)" == "food" {
            collisionBetween(ball: contact.bodyB.node!, object: contact.bodyA.node!)
        } else if "\(Item(name: (contact.bodyA.node?.name) ?? "").type)" == "beverage" {
            collisionBetween(ball: contact.bodyA.node!, object: contact.bodyB.node!)
        } else if "\(Item(name: (contact.bodyB.node?.name) ?? "").type)" == "beverage" {
            collisionBetween(ball: contact.bodyB.node!, object: contact.bodyA.node!)
        }
    }
    
    func add(item: Item) {
//            let imageName = (item.name.prefix(1).lowercased() + item.name.replacingOccurrences(of: " ", with: "").dropFirst())
            let imageName = item.imageName
            let itemSprite = SKSpriteNode(imageNamed: imageName)
            itemSprite.size = Constants.itemSpriteSize
            itemSprite.position = CGPoint(x: Constants.centerOfFirstSceneX, y: screenHeight / 2)
            itemSprite.physicsBody = SKPhysicsBody(rectangleOf: Constants.itemSpriteSize)
            itemSprite.physicsBody!.contactTestBitMask = itemSprite.physicsBody!.collisionBitMask
            //itemSprite.name = "\(item.type)"
            itemSprite.name = "\(item.name)"
            print("\(itemSprite.name!)")
            
            addChild(itemSprite)
            
    }
    
    func moveScene() {
        if firstScene {
            moveBox!.run(SKAction.moveTo(x: Constants.centerOfSecondSceneX, duration: 1))
            box!.run(SKAction.moveTo(x: Constants.centerOfSecondSceneX, duration: 1))

            firstScene = false
        } else {
            moveBox!.run(SKAction.moveTo(x: Constants.centerOfFirstSceneX, duration: 1))
            box!.run(SKAction.moveTo(x: Constants.centerOfFirstSceneX, duration: 1))

            firstScene = true
        }
        
    }
    
    func shower() {
            
        
        let delay = SKAction.wait(forDuration: 1)
        let stationary = SKAction.moveTo(y: 525, duration: 9)
        let turnOffShower = SKAction.run {
            self.isShowering = false
        }
        let sequence = SKAction.sequence([delay, stationary, turnOffShower])
        
        box!.run(SKAction.moveTo(x: -screenWidth / 2, duration: 1))
        box!.run(SKAction.moveTo(y: 525, duration: 1))
//        let moveToShowerX = SKAction.moveTo(x: -screenWidth / 2, duration: 1)
//        let moveToShowerY = SKAction.moveTo(y: 525, duration: 1)
//        let wait = SKAction.wait(forDuration: 3)
//        let moveToShowerX2 = SKAction.moveTo(x: -screenWidth / 2 - 1, duration: 5)
//
//        let sequence = SKAction.sequence([moveToShowerY, wait, moveToShowerX, moveToShowerX2])
        isShowering = true
        
        box!.run(sequence)

    
//        let waterDrop = SKSpriteNode(color: .systemBlue, size: CGSize(width: 5, height: 10))
//        waterDrop.position = CGPoint(x: CGFloat.random(in: (-screenWidth / 2 - 20)...(-screenWidth / 2 + 20)), y: 700)
//        waterDrop.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 5, height: 10))
//        waterDrop.name = "waterDrop"
        //waterDrop.physicsBody?.categoryBitMask = 0b001
        
        
        
        
    }
}

class WaterDrop: SKSpriteNode {
    
    init(startPosition: CGPoint) {
        
        let texture = SKTexture(imageNamed: "drink")
        super.init(texture: texture, color: .systemBlue, size: CGSize(width: 5, height: 10))
        
        self.name = "waterDrop"
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 5, height: 10))
        position = CGPoint(x: startPosition.x, y: startPosition.y)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
}

//class ItemSprite: SKSpriteNode {
//    var type: Item.types
//    var name: String
//
//}

//class GameSceneViewModel: ObservableObject {
//    @Published var gameScene: GameScene
//
//    init() {
//        self.gameScene = GameScene()
//            //scene.setup(with: viewModel)
//        self.gameScene.size = CGSize(width: 400, height: 700)
//        self.gameScene.scaleMode = .fill
//        self.gameScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//    }
//
//    func add(item: String) {
//        gameScene.add(item: item)
//    }
//}

struct GameScene_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(DeadPetsVM: DeadPetUserDefaults())
    }
}
