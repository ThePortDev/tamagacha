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
                VStack {
                    SpriteView(scene: scene)
                        .frame(width: 400, height: 700)
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                statView
//                swipeLeft
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
