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
                HouseView(activeView: self.activeView)
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


// MARK: ADD FILES

// View Files
/// HouseView
struct HouseView: View {
    @State var activeView: currentView
    @State var isExpanded = false
    
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 400, height: 700)
        scene.scaleMode = .fill
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        return scene
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    SpriteView(scene: scene)
                        .frame(width: 400, height: 700)
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                statView
                swipeLeft
            }
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
    
    var swipeLeft: some View {
        ZStack {
        Rectangle()
            Image(systemName: "arrow.right")
                .foregroundColor(Color.black)
        }
        .foregroundColor(.purple)
        .cornerRadius(20, corners: [.topRight, .bottomRight])
        .frame(width: 20, height: 100)
        .padding(.trailing, screenWidth - 20)
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
            .padding(.top, 70)
            .padding(.bottom, 550)
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

/// StoreView
struct StoreView: View {
    @Binding var activeView: currentView
    @Binding var navigateToSettings: Bool
    @Binding var navigateToToyChest: Bool
    @Binding var navigateToKitchen: Bool

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack {

                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.red)
                    Text("Store")
                    VStack {
                        activeView == .center ? Image(systemName: "arrow.up") : Image(systemName: "arrow.down")
                        if activeView == .center {
                            HStack {

                                Button("Kitchen") {
                                    navigateToKitchen = true
                                }
                                Button("Toychest") {
                                    navigateToToyChest = true
                                }
                                Button("Settings") {
                                    navigateToSettings = true
                                }

                            }}
                        
                    }
                    .padding(.bottom, 700)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

/// BathroomView
struct BathroomView: View {
    @State var activeView: currentView
    
    var body: some View {
        GeometryReader { geometry in
            Text("Bathroom")
                .frame(width: screenSize.size.width, height: screenSize.size.height, alignment: .center)
        }
        .background(Color.purple)
        .edgesIgnoringSafeArea(.all)
    }
}

/// SettingsView
struct SettingsView: View {
    @State var enterCode = ""
    @State var navigateToDevTools = false
    var devCode = "cheesepuffs"
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text("Settings")
            Button("Back") {
                presentationMode.wrappedValue.dismiss()
            }
            
            TextField("Code", text: $enterCode)
                .multilineTextAlignment(.center)
                .autocorrectionDisabled()
                .onSubmit {
                    if enterCode.lowercased() == devCode {
                        navigateToDevTools = true
                    }
                }
            
        }
        .navigate(to: DeveloperToolsView(), when: $navigateToDevTools)

    }
    
}

/// ToychestView
struct ToychestView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text("Toychest")
            Button("Back") {
                presentationMode.wrappedValue.dismiss()
            }
            
        }
    }
    
}

/// KitchenView
struct KitchenView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text("Kitchen")
            Button("Back") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
}

/// DeveloperToolsView
struct DeveloperToolsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text("DevTools")
            Button("Back") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

// Extentions
/// RoundedRectangle
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

/// NavigateIfTrue
extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        NavigationView {
            ZStack {
                self
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                NavigationLink(
                    destination: view
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                    isActive: binding
                ) {
                    EmptyView()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

