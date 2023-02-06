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
    @Binding var wentToStoreFromBathroom: Bool
    
    @Binding var selectedTab: String
    @Binding var navigateToSettings: Bool
    @Binding var navigateToMiniGame: Bool
    @Binding var navigateToGraveyard: Bool
        
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .frame(width: screenWidth, height: 1100)
                .foregroundColor(.blue)
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    HStack(spacing: 0) {
                        TabBarButton(activeView: $activeView, wentToStoreFromBathroom: $wentToStoreFromBathroom, image: "house", selectedTab: $selectedTab)
                        TabBarButton(activeView: $activeView, wentToStoreFromBathroom: $wentToStoreFromBathroom, image: "bookmark", selectedTab: $selectedTab)
                        //TabBarButton(image: "message", selectedTab: $selectedTab)
                        TabBarButton(activeView: $activeView, wentToStoreFromBathroom: $wentToStoreFromBathroom,image: "sportscourt", selectedTab: $selectedTab)
                        SettingsButton(activeView: $activeView, image: "gearshape", navigateToSettings: $navigateToSettings)
                        //MiniGameButton(activeView: $activeView, image: "1.circle", navigateToMiniGame: $navigateToMiniGame)
                        GraveyardButton(image: "🪦", navigateToGraveyard: $navigateToGraveyard)

                    }
                    .background(Color.white)
//                    .frame(height: (activeView != .bottom ? 100 : 100))
//                    .padding(.bottom, (activeView != .bottom ? 0 : 100))
                    
                    .cornerRadius(30, corners: [.topRight, .topLeft])
                    //.padding(.horizontal)
                    //.padding(.top, 100)
                }
                //.frame(height: (activeView != .bottom ? 100 : 500))
                .offset(y: (activeView != .bottom ? 0 : 200))
                testView
            }
        }
    }
    
    var testView: some View {
        ZStack {
            VStack {
                Text("Money: 💲\(viewModel.store.money)")
                Button {
                    withAnimation {
                        if !wentToStoreFromBathroom {
                            activeView = .center
                        } else {
                            activeView = .left
                        }
                        selectedTab = ""
                    }
                } label: {
                    Text("Back to home")
                        .foregroundColor(.white)
                }
            }
            .font(.custom("HangTheDj", size: 20))

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
        .padding(.top, 200)
        .padding(.leading, 10)
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
                    Text("Price: 💲\(withItem.price)")
                }
                .font(.custom("Yoster Island", size: 15))
            }
        }
            .disabled(viewModel.store.money < withItem.price)
        }
    }
}

struct TabBarButton: View {
    
    @Binding var activeView: currentView
    @Binding var wentToStoreFromBathroom: Bool
    
    var image: String
    @Binding var selectedTab: String
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                SoundManager.soundInstance.playSound(sound: .click)
                withAnimation {
                    if activeView != .bottom {
                        if activeView == .center {
                            wentToStoreFromBathroom = false
                        } else {
                            wentToStoreFromBathroom = true
                        }
                        activeView = .bottom
                    }
                    selectedTab = image
                }
                
            }) {
                Image(systemName: "\(image)\(selectedTab == image ? ".fill" : "")")
                    .font(.system(size: 25, weight: .semibold))
                    .offset(y: selectedTab == image ? -10 : 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 100)
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
        HomeView(DeadPetsVM: DeadPetUserDefaults())
    }
}

import SpriteKit

struct MiniGameView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Text("Back")
        }

    }
}
    
//    struct MiniGameView: View {
//        @EnvironmentObject var viewModel: PetViewModel
//
//        @Environment(\.dismiss) var dismiss
//
//        @State var activeView = currentView.center
//    //    @State private var timeRemaining = 3
//    //    static var timerCount = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//
//        var body: some View {
//            ZStack {
//                    SpriteView(scene: viewModel.miniGameScene)
//                        .frame(width: screenWidth, height: screenHeight)
//                    //.ignoresSafeArea()
//
//                    VStack {
//                        Text("Hearts: \(viewModel.catchModel.hearts)")
//                        Text("Money: \(viewModel.catchModel.catchMiniGameMoneyMade)")
//                            .padding(.bottom, 500)
//                    }
//                    Image("cloud")
//                        .resizable()
//                        .frame(width: screenWidth, height: 150)
//                        .padding(.top, 150)
//                if viewModel.catchModel.died {
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 15)
//                        VStack {
//                            Text("Game Over \n Money Collected: \(viewModel.catchModel.catchMiniGameMoneyMade)")
//                                .multilineTextAlignment(.center)
//                                .foregroundColor(.white)
//                            Button {
//                                dismiss()
//                            } label: {
//                                Text("Home")
//                            }
//
//                            Button {
//                                viewModel.resetCatchGame()
//                            } label: {
//                                Text("Play Again")
//                            }
//                        }
//                    }
//                    .frame(width: 200, height: 200)
//                }
//            }
//        }
//    }
//
//    class CatchMiniGameScene: SKScene, SKPhysicsContactDelegate {
//
//        var viewModel: PetViewModel!
//
//        func setup(with viewModel: PetViewModel) {
//            self.viewModel = viewModel
//        }
//
//        private var currentNode: SKNode?
//
//        var draggablePet: SKSpriteNode?
//        var slider: SKSpriteNode?
//        var sliderKnob: SKSpriteNode?
//
//        //Boolean
//        var isPlayerAlive = true
//        var sliderAction = false
//
//        let objectsPosition = CGFloat.random(in: 0...1)
//
//        // Measure
//        var knobLength: CGFloat = screenWidth
//
//        //Timer
//        var timerCount = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//
//        // Sprite Engine
//        var previousTimeInterval: TimeInterval = 0
//        let playerSpeed = 4.0
//
//        var levelTimerLabel = SKLabelNode(fontNamed: "ArialMT")
//
//        var levelTimerValue: Int = 3 {
//            didSet {
//                levelTimerLabel.text = "Time left: \(levelTimerValue)"
//            }
//        }
//
//        override func didMove(to view: SKView) {
//            let background = SKSpriteNode(imageNamed: "tennisBall")
//            background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//            background.position = CGPoint.zero
//            addChild(background)
//
//            draggablePet = SKSpriteNode(imageNamed: "cheesepuffs")
//            draggablePet!.position = CGPoint(x: 0.5, y: -screenHeight / 3.5)
//            draggablePet!.size = CGSize(width: 50, height: 50)
//            draggablePet!.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
//            draggablePet!.name = "draggable"
//            draggablePet!.physicsBody?.categoryBitMask = 0b001
//            addChild(draggablePet!)
//
//            slider = SKSpriteNode(imageNamed: "cheesepuffs")
//            slider?.position = CGPoint(x: 0.5, y: -screenHeight / 2 + 100)
//            slider?.size = CGSize(width: screenWidth, height: 30)
//            addChild(slider!)
//            sliderKnob = SKSpriteNode(imageNamed: "tennisBall")
//            sliderKnob?.position = CGPoint(x: 0.5, y: -screenHeight / 2 + 100)
//            sliderKnob?.size = CGSize(width: 50, height: 50)
//            addChild(sliderKnob!)
//
//    //        levelTimerLabel.fontColor = SKColor.blackColor()
//    //        levelTimerLabel.fontSize = 40
//    //        levelTimerLabel.position = CGPoint(x: size.width/2, y: size.height/2 + 350)
//    //        levelTimerLabel.text = "Time left: \(levelTimerValue)"
//    //        addChild(levelTimerLabel)
//    //
//    //        let block = SKAction.run({
//    //                [unowned self] in
//    //
//    //                if self.levelTimerValue > 0{
//    //                    self.levelTimerValue -= 1
//    //                }else{
//    //                    self.removeAction(forKey: "countdown")
//    //                }
//    //            })
//
//            //physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
//
//            physicsBody = SKPhysicsBody(edgeChainFrom: CGPath(rect: CGRect(x: 0/* - 100*/, y: screenHeight, width: screenWidth, height: screenHeight), transform: nil))
//
//            physicsWorld.contactDelegate = self
//
//            self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
//        }
//
//        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//            if action(forKey: "countdown") != nil {removeAction(forKey: "countdown")}
//
//            for touch in touches {
//                if let sliderKnob = sliderKnob {
//                    let location = touch.location(in: self) // self || slider
//                    sliderAction = sliderKnob.frame.contains(location)
//                }
//            }
//
//        }
//
//        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//            if !viewModel.catchModel.died {
//                //guard let slider = slider else { return }
//                guard let sliderKnob = sliderKnob else { return }
//                guard let draggablePet = draggablePet else { return }
//
//                if !sliderAction { return }
//
//                // Distance
//                for touch in touches {
//                    let position = touch.location(in: self)// self || slider
//
//                    //            let length = sqrt(pow(position.y, 2) + pow(position.x, 2))
//                    //            let angle = atan2(position.y, position.x)
//                    //
//                    //            if knobLength > length {
//                    if position.x < -screenWidth / 2 + 25 || position.x > screenWidth / 2 - 25 {
//                        return
//                    } else {
//                        sliderKnob.position.x = position.x
//                        draggablePet.position.x = position.x
//                    }
//                    //            } else {
//                    //                sliderKnob.position = CGPoint(x: cos(angle) * knobLength, y: sin(angle) * knobLength)
//                    //            }
//                }
//            }
//        }
//
//        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//            for touch in touches {
//                let xSliderCoordinate = touch.location(in: slider!).x
//                let xLimit: CGFloat = 400.0
//                if xSliderCoordinate > -xLimit && xSliderCoordinate < xLimit {
//
//                }
//            }
//        }
//
//    //    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//    //        self.currentNode = nil
//    //    }
//
//        override func update(_ currentTime: TimeInterval) {
//            //let deltaTime = currentTime - previousTimeInterval
//            previousTimeInterval = currentTime
//
//            if draggablePet?.position.y !=  -screenHeight / 3.5 {
//                draggablePet?.position.y =  -screenHeight / 3.5
//            }
//
//            //Player movement
//    //        guard let sliderKnob = sliderKnob else { return }
//    //        let xPosition = Double(sliderKnob.position.x)
//    //        let displacement = CGVector(dx: deltaTime * xPosition, dy: 0)
//    //        let move = SKAction.move(by: displacement, duration: 0)
//    //        draggablePet?.move(move)
//
//
//            //createWave()
//            for child in children {
//                if child.frame.maxY < -screenHeight / 2 {
//                    if child.name == "money" || child.name == "badNode" {
//                        child.removeFromParent()
//                    }
//                }
//            }
//
//            let activeObjects = children.compactMap { $0 as? FallingNode }
//
//            if activeObjects.count < 3 {
//                createWave()
//            }
//
//
//        }
//
//        func collisionBetween(ball: SKNode, object: SKNode) {
//            if object.name! == "money" {
//                destroy(object: object)
//                if !viewModel.catchModel.died {
//                    viewModel.catchModel.addMoneyMade(amount: 1)
//                }
//            } else if object.name! == "money" {
//                destroy(object: object)
//                if !viewModel.catchModel.died {
//                    viewModel.catchModel.addMoneyMade(amount: 1)
//                }
//            } else if object.name! == "badNode" {
//
//                destroy(object: object)
//                if !viewModel.catchModel.died {
//                    viewModel.catchModel.minusHeart()
//                }
//            } else if object.name! == "badNode" {
//                destroy(object: object)
//                if !viewModel.catchModel.died {
//                    viewModel.catchModel.minusHeart()
//                }
//            }
//        }
//
//        func destroy(object: SKNode) {
//            object.removeFromParent()
//        }
//
//        func didBegin(_ contact: SKPhysicsContact) {
//            if (contact.bodyA.node != nil && contact.bodyB.node != nil) {
//
//                if contact.bodyA.node?.name == "draggable" {
//                    collisionBetween(ball: contact.bodyA.node!, object: contact.bodyB.node!)
//                } else if contact.bodyB.node?.name! == "draggable" {
//                    collisionBetween(ball: contact.bodyB.node!, object: contact.bodyA.node!)
//                }
//            }
//        }
//
//        func createWave() {
//            guard isPlayerAlive else { return }
//
//            let objectOffsetY: CGFloat = 100
//            let objectStartY = 200
//
//            let moneyNode = FallingNode(startPosition: CGPoint(x: Int.random(in: Int(-screenWidth / 2 + 50)...Int(screenWidth / 2 - 50)), y: objectStartY), yOffset: objectOffsetY, moveStraight: true, name: "money", size: CGSize(width: 25, height: 25))
//            let badNode = FallingNode(startPosition: CGPoint(x: Int.random(in: Int(-screenWidth / 2 + 50)...Int(screenWidth / 2 - 50)), y: objectStartY), yOffset: objectOffsetY, moveStraight: true, name: "badNode", size: CGSize(width: 40, height: 40))
//
//            if Int.random(in: 1...3) > 2 {
//                addChild(badNode)
//            } else {
//                addChild(moneyNode)
//            }
//        }
//
//    //    func resetKnobPosition() {
//    //        let initialPoint = CGPoint(x: 0, y: 0)
//    //        let moveBack = SKAction.move(to: initialPoint, duration: 0.1)
//    //        moveBack.timingMode = .linear
//    //        sliderKnob?.run(moveBack)
//    //        sliderAction = false
//    //    }
//    }
//
//    class FallingNode: SKSpriteNode {
//    //    var amount: Int {
//    //        if Int.random(in: 1...5) > 4 {
//    //            return 20
//    //        } else {
//    //            return 5
//    //        }
//    //    }
//
//        var setSpeed: CGFloat {
//            switch self.name {
//                case "money":
//                    return CGFloat.random(in: 100...600)
//                default:
//                    return CGFloat.random(in: 100...400)
//            }
//        }
//
//        init(startPosition: CGPoint, yOffset: CGFloat, moveStraight: Bool, name: String, size: CGSize) {
//
//            let texture = SKTexture(imageNamed: name == "money" ? "tennisBall" : "bombclipart")
//            super.init(texture: texture, color: .blue, size: size)
//
//            self.name = name
//
//
//            physicsBody = SKPhysicsBody(texture: texture, size: size)
//            physicsBody!.contactTestBitMask = 0b001
//    //        physicsBody?.categoryBitMask = 0b001
//    //        physicsBody?.collisionBitMask = 0b001
//
//
//            position = CGPoint(x: startPosition.x, y: startPosition.y + yOffset)
//
//                configureMovement(moveStraight)
//        }
//
//        required init?(coder aDecoder: NSCoder) {
//            fatalError("error")
//        }
//
//        func configureMovement(_ moveStraight: Bool) {
//            let path = UIBezierPath()
//            path.move(to: .zero)
//
//            if moveStraight {
//                path.addLine(to: CGPoint(x: 0, y: -10000))
//            }
//
//            let movement = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, speed: self.setSpeed)
//            let sequence = SKAction.sequence([movement, .removeFromParent()])
//            run(sequence)
//        }
//    }
//
//    class PetNode: SKSpriteNode {
//        var hearts: Int = 3
//
//        func minusHeart() {
//            self.hearts -= 1
//        }
//
//        var died: Bool {
//            switch hearts {
//                case 0:
//                    return true
//                default:
//                    return false
//            }
//        }
//    }
//
//struct CatchMiniGameModel {
//
//    var catchMiniGameMoneyMade: Int
//    var hearts: Int
//    var died: Bool {
//        switch hearts {
//            case 0:
//                return true
//            default:
//                return false
//        }
//    }
//
////    var died: Bool {
////        get {
////            hearts > 0 ? false : true
////        }
////    }
//
//    init() {
//        self.hearts = 3
//        self.catchMiniGameMoneyMade = 0
//    }
//
//    mutating func addMoneyMade(amount: Int) {
//        catchMiniGameMoneyMade += amount
//    }
//
//    mutating func minusHeart() {
//        self.hearts -= 1
//    }
//
//    mutating func resetCatchGame() {
//        self.hearts = 3
//        self.catchMiniGameMoneyMade = 0
//    }
//
//
//}
