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
    @Binding var wentToStoreFromBathroom: Bool
    
    @State var isExpanded = false
    @State var expandInventory = false
    
    //@StateObject var sceneViewModel = GameSceneViewModel()
    
    @EnvironmentObject var viewModel: PetViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                SpriteView(scene: viewModel.gameScene)
                    .frame(width: screenWidth, height: screenHeight)
                    .ignoresSafeArea()
                BathroomView(activeView: $activeView)
                    .offset(x: (activeView == .left ? 0 : -screenWidth))
                InventoryView(expandInventory: $expandInventory)
                    .offset(y: (!expandInventory ? -screenHeight + 100 : -50))
                    .offset(x: activeView == .center || activeView == .bottom ? screenWidth - 50 : screenWidth * 2)
                    .zIndex(100)
                
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
                    .offset(x: activeView != .left ? 0 : screenWidth)
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
    
    @Binding var expandInventory: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack() {
                Rectangle()
                    .foregroundColor(.orange)
                    .cornerRadius(10, corners: [.bottomLeft])
                    .frame(width: 100, height: screenHeight)
                
                VStack(spacing: 0) {
                    
                    VStack {
                        ForEach(Array(viewModel.store.inventory.keys), id: \.self) { item in
                            if viewModel.store.inventory[item]! > 0 {
                                Button {
                                    SoundManager.soundInstance.playSound(sound: .plop)
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
                
                if expandInventory {
                    Button {
                        withAnimation {
                            expandInventory = false
                        }
                    } label: {
                        VStack {
                            Image(systemName: "chevron.up")
                        }
                    }
                    .padding(.top, screenHeight - 200)
                }
                
                Button {
                    withAnimation {
                        expandInventory = true
                    }
                } label: {
                    VStack {
                        Text("Inventory")
                        Image(systemName: "chevron.down")
                    }
                }
                .padding(.top, screenHeight - 50)

                
            }
        }
    }
}


struct HomeView_Previews3: PreviewProvider {
    static var previews: some View {
        HomeView(DeadPetsVM: DeadPetUserDefaults())
    }
}
