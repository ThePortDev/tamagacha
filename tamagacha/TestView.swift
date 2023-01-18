
import SwiftUI
import SpriteKit

class GameScene: SKScene {
    
    //@State var sceneSize:CGSize = CGSize(width: 400, height: 700)
    
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
            VStack {
                house
                menu
            }
            welcomeMessage
                .padding(.bottom, 700)
        }
        .onTapGesture {
            withAnimation {
                showWelcomeMessage = false
            }
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
    var house: some View {
            SpriteView(scene: scene)
                .frame(width: 400, height: 700)
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


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
