
import SwiftUI
import SpriteKit

enum currentView {
    case center
    case bottom
}
let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height

class GameScene: SKScene {
    
    //@State var sceneSize:CGSize = CGSize(width: 400, height: 700)
    
    private var spriteAtlas
    

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

struct TestView: View {
    
    @State var activeView = currentView.center
    @State var viewState = CGSize.zero
    
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 400, height: 700)
        scene.scaleMode = .fill
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        return scene
    }
    
    @State private var showWelcomeMessage = true
    
    var body: some View {
        ZStack {
            PetHomeView(activeView: self.activeView)
                .animation(.easeInOut)
            StoreView(activeView: self.activeView)
                .offset(y: self.activeView == currentView.bottom ? 0 : -screenHeight)
                //.offset(y: activeView != .bottom ? viewState.width : 0)
                .animation(.easeInOut)
        }
        .gesture(
            (self.activeView == currentView.center) ?

            DragGesture().onChanged { value in
                self.viewState = value.translation
            }
                .onEnded { value in
                    if value.predictedEndTranslation.height > screenHeight / 2 {
                        self.activeView = currentView.bottom
                        self.viewState = .zero
                    }
                    else {
                        self.viewState = .zero
                    }
                }
            : DragGesture().onChanged { value in
                switch self.activeView {
                    case.bottom:
                        guard value.translation.height < 1 else { return }
                        self.viewState = value.translation
                    case.center:
                        self.viewState = value.translation
                }
            }
                .onEnded { value in
                    switch self.activeView {
                        case.bottom:
                            if value.predictedEndTranslation.height < -screenHeight / 2 {
                                self.activeView = .center
                                self.viewState = .zero
                            } else {
                                self.viewState = .zero
                            }
                        case .center:
                            self.viewState = .zero
                    }
                }
            )
    }
    
//    var body: some View {
//        ZStack {
//            PetHomeView(activeView: self.activeView)
//                .animation(.easeInOut)
//            StoreView(activeView: self.activeView)
//                .offset(x: self.activeView == currentView.left ? 0 : -screenWidth)
//                .offset(x: activeView != .right ? viewState.width : 0)
//                .animation(.easeInOut)
//        }
//        .gesture(
//            (self.activeView == currentView.center) ?
//
//            DragGesture().onChanged { value in
//                self.viewState = value.translation
//            }
//                .onEnded { value in
//                    if value.predictedEndTranslation.width > screenWidth / 2 {
//                        self.activeView = currentView.left
//                        self.viewState = .zero
//                    }
//                    else if value.predictedEndTranslation.width < -screenWidth / 2 {
//                        self.activeView = currentView.right
//                        self.viewState = .zero
//                    }
//                    else {
//                        self.viewState = .zero
//                    }
//                }
//
//            : DragGesture().onChanged { value in
//                switch self.activeView {
//                    case.left:
//                        guard value.translation.width < 1 else { return }
//                        self.viewState = value.translation
//                    case.right:
//                        guard value.translation.width > 1 else { return }
//                        self.viewState = value.translation
//                    case.center:
//                        self.viewState = value.translation
//                }
//            }
//                .onEnded { value in
//                    switch self.activeView {
//                        case.left:
//                            if value.predictedEndTranslation.width < -screenWidth / 2 {
//                                self.activeView = .center
//                                self.viewState = .zero
//                            }
//                            else {
//                                self.viewState = .zero
//                            }
//                        case .right:
//                            if value.predictedEndTranslation.width > screenWidth / 2 {
//                                self.activeView = .center
//                                self.viewState = .zero
//                            }
//                            else {
//                                self.viewState = .zero
//                            }
//                        case .center:
//                            self.viewState = .zero
//                    }
//                }
//        )
//    }
//

     
    var welcomeMessage: some View {
        Group {
            if showWelcomeMessage {
                Text("Welcome Home!")
                    .font(.title)
            }
        }
    }
    var house: some View {
            SpriteView(scene: scene)
                .frame(width: 400, height: 700)
    }
    var store: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(.blue)
    }
    var menu: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .ignoresSafeArea()
                .frame(height: 75)
                .foregroundColor(Color.red)
            HStack {
                Text("Kitchen")
                    .padding(.trailing)
                Text("Toychest")
                    .padding(.horizontal)
                Text("Settings")
                    .padding(.leading)
            }
            .padding(.top, 20)
            
        }
    }
}

struct PetHomeView: View {
    @State var activeView: currentView
    
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 400, height: 700)
        scene.scaleMode = .fill
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        return scene
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                SpriteView(scene: scene)
                    .frame(width: 400, height: 700)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
        .background(Color.blue)
        .edgesIgnoringSafeArea(.all)
    }
    
    
}

struct StoreView: View {
    @State var activeView: currentView
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.red)
                    Text("Store")
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
        .background(Color.yellow)
        .edgesIgnoringSafeArea(.all)
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
