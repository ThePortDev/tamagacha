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
                    .offset(x: !wentToStoreFromBathroom && activeView == .bottom || activeView == .center ? -screenWidth : 0)

                InventoryView(expandInventory: $expandInventory)
                    .offset(y: (!expandInventory ? Constants.collapsedInventoryYOffset : Constants.expandedInventoryYOffset))
                    .offset(x: !wentToStoreFromBathroom && activeView == .bottom || activeView == .center ? screenWidth - 50 : screenWidth * 2)

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
                VStack {
                    expandedStatView

                    .offset(x: !wentToStoreFromBathroom && activeView == .bottom || activeView == .center ? -50 : screenWidth)

                        .offset(y: -100)

                    //.zIndex(.infinity)
                    //                Text("starting: \(startingOffsetY) \n current: \(currentDragOffsetY) \n ending: \(endingOffsetY)")
                    
                    //                Button("change scene") {
                    //                    withAnimation {
                    ////                        changeScene.toggle()
                    //                    }
                }   //                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height /*- 100*//*, alignment: .center*/)
        }
        //.animation(Animation.linear(duration: 1), value: isExpanded)
        //.background(Color.white)
        //.edgesIgnoringSafeArea(.all)
    }
    
    var expandedStatView: some View {
        StatView()
            .frame(width: 300, height: 230)
            .padding(.top, 100)
            .padding(.bottom, 500)
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
    

//    var expandedStatView: some View {
//        StatView()
//            .frame(width: 300, height: 230)
//            .padding(.top, 100)
//            .padding(.bottom, 500)
//    }
    
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

struct InventoryView: View {
    @EnvironmentObject var viewModel: PetViewModel
    
    @Binding var expandInventory: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack() {
                Rectangle()
                    .foregroundColor(ThemeColors.inventoryButton)
                    .cornerRadius(Constants.inventoryCornerRadius, corners: [.bottomLeft])
                    .frame(width: Constants.inventoryFrameWidth, height: Constants.inventoryFrameHeight)
                
                VStack(spacing: 0) {
                        ScrollView {
                            ForEach(Array(viewModel.store.inventory.keys), id: \.self) { item in
                                if viewModel.store.inventory[item]! > 0 {
                                    Button {
                                        SoundManager.soundInstance.playSound(sound: .plop)
                                        viewModel.add(item: item)
                                        viewModel.remove(item: item.name)
                                    } label: {
                                        HStack {
                                            Text("\(viewModel.store.inventory[item]!)")
                                                .foregroundColor(ThemeColors.accent)
                                            Image(item.imageName)
                                                .multilineTextAlignment(.center)
                                        }
                                    }
                                    
                                    
                                }
                            }
                        }
                    .padding(.top, 100)
                    .padding(.trailing)
                    
                }
                .padding(.trailing, 5)
                
                if expandInventory {
                    Button {
                        withAnimation {
                            expandInventory = false
                        }
                    } label: {
                        VStack {
                            Image(systemName: "chevron.up")
                                .foregroundColor(ThemeColors.primaryText)
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
                            .font(.custom("Yoster Island", size: 15))
                            .foregroundColor(ThemeColors.primaryText)
                        Image("inventoryBackpack")
                            .font(.custom("Yoster Island", size: 34))
                            .foregroundColor(ThemeColors.primaryText)
                        Spacer()
                        Image(systemName: "chevron.down")
                            .foregroundColor(ThemeColors.primaryText)
                    }
                }
                .padding(.trailing, 10)
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
