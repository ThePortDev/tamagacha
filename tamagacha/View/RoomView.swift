//
//  RoomView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/19/23.
//

import SwiftUI
import SpriteKit

struct RoomView: View {
    
    @Binding var activeView: currentView
    @State var isExpanded = false
    
    //@StateObject var sceneViewModel = GameSceneViewModel()
    
    @EnvironmentObject var viewModel: PetViewModel
    
    
    // Inventory drag
    @State private var startingOffsetY: CGFloat = screenHeight + 250
    @State private var currentDragOffsetY: CGFloat = 0
    @State private var endingOffsetY: CGFloat = 0
    
    //    var scene: SKScene {
    //        let scene = GameScene()
    //        scene.setup(with: viewModel)
    //        scene.size = CGSize(width: 400, height: 700)
    //        scene.scaleMode = .fill
    //        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    //        return scene
    //    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                SpriteView(scene: viewModel.gameScene)
                    .frame(width: screenWidth, height: screenHeight)
                    .ignoresSafeArea()
                BathroomView(activeView: $activeView)
                    .offset(x: (activeView == .left ? 0 : -screenWidth))
                InventoryView()
                    .offset(x: (activeView == .left ? screenWidth : 0))
                    .zIndex(.infinity)
                    .frame(width: screenWidth, height: screenHeight + 800)
                    .padding(.leading, 600)
                    .offset(y: startingOffsetY)
                    .offset(y: currentDragOffsetY)
                    .offset(y: endingOffsetY)
                    .gesture (
                        DragGesture()
                            .onChanged { value in
                                withAnimation(.spring()) {
                                    if  value.translation.height > 200 {
                                        return
                                    } else {
                                        currentDragOffsetY = value.translation.height
                                    }
                                }
                            }
                            .onEnded({ value in
                                withAnimation(.spring()) {
                                    if currentDragOffsetY < -100 {
                                        endingOffsetY = -startingOffsetY + 400
                                        
                                    }
                                    else if endingOffsetY != 0 && currentDragOffsetY > 50{
                                        endingOffsetY = 0
                                        isExpanded = true
                                        print(isExpanded)
                                    }
                                    currentDragOffsetY = 0
                                }
                            })
                    )
                
//                Group {
//                    NavigationLink {
//                        GraveyardView()
//                            .environmentObject(viewModel)
//                    } label: {
//                        CoolRect(text: "Graveyard", gradientColors: [.blue, .black])
//                    }
//                }
//                .offset(x: (activeView == .center ? 0 : screenWidth))
//                    .frame(width: 100, height: 100)
                    expandedStatView

                    //.zIndex(.infinity)
//                Text("starting: \(startingOffsetY) \n current: \(currentDragOffsetY) \n ending: \(endingOffsetY)")
                
                //                Button("change scene") {
                //                    withAnimation {
                ////                        changeScene.toggle()
                //                    }
                //                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height /*- 100*//*, alignment: .center*/)
        }
        //.animation(Animation.linear(duration: 1), value: isExpanded)
        //.background(Color.white)
        //.edgesIgnoringSafeArea(.all)
    }
    
    var inventoryView: some View {
        GeometryReader { geometry in
            ZStack() {
                Rectangle()
                    .foregroundColor(.orange)
                    .cornerRadius(10, corners: [.topLeft, .bottomRight])
                    .frame(width: 100, height: screenHeight)
                VStack(spacing: 0) {
                    Image(systemName: "chevron.up")
                    Text("Inventory")
                    VStack {
                        ForEach(Array(viewModel.store.inventory.keys), id: \.self) { item in
                            if viewModel.store.inventory[item]! > 0 {
                                Text("\(item.name):\n \(viewModel.store.inventory[item]!)")
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                    .padding(.top, 100)
                    .padding(.trailing)
                }
                .padding(.bottom, 600)
                .padding(.trailing, 5)
            }
        }
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
            StatView()
            .frame(width: screenWidth / 2, height: 200)
            .padding(.top, 100)
            .padding(.bottom, 500)
            .padding(.trailing, 200)
        
//        ZStack {
//            Rectangle()
//            Text("Stats")
//                .foregroundColor(Color.red)
//        }
//        .cornerRadius(20, corners: [.topLeft, .bottomLeft])
//        .frame(width: 50, height: 100)
        //        .background(Color.blue)
    }
    
    
}

struct BathroomView2: View {
    @EnvironmentObject var viewModel: PetViewModel
    
    var body: some View {
        Text("Bathroom")
    }
}

struct InventoryView: View {
    @EnvironmentObject var viewModel: PetViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack() {
                Rectangle()
                    .foregroundColor(.orange)
                    .cornerRadius(10, corners: [.topLeft, .bottomRight])
                    .frame(width: 100, height: screenHeight)
                
                VStack(spacing: 0) {
                    Image(systemName: "chevron.up")
                    Text("Inventory")
                    VStack {
                        ForEach(Array(viewModel.store.inventory.keys), id: \.self) { item in
                            if viewModel.store.inventory[item]! > 0 {
                                Button {
                                    viewModel.add(item: item)
                                    viewModel.remove(item: item.name)
                                } label: {
                                    Text("\(item.name):\n \(viewModel.store.inventory[item]!)")
                                        .multilineTextAlignment(.center)
                                }
                                
                                
                            }
                        }
                    }
                    .padding(.top, 100)
                    .padding(.trailing)
                }
                .padding(.bottom, 600)
                .padding(.trailing, 5)
            }
        }
    }
}


struct HomeView_Previews3: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
