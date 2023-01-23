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
                SpriteView(scene: scene)
                    .frame(width: 400, height: UIScreen.main.bounds.height - 100)
                statView
                    .zIndex(.infinity)
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

struct HomeView_Previews3: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
