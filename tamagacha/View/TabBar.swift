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
    
    @Namespace var storeItemsNameSpace
    
    @State var background = "tabbar"
        
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                //.ignoresSafeArea()
                .frame(width: screenWidth, height: screenHeight)
                .foregroundColor(.blue)
                .offset(y: 154)
            
            VStack(spacing: 0) {
//                if activeView == .bottom {
//                    backButton
//                }
                HStack(spacing: 0) {
                    HStack(spacing: 0) {
                        TabBarButton(activeView: $activeView, wentToStoreFromBathroom: $wentToStoreFromBathroom, background: $background, image: "burger", selectedTab: $selectedTab)
                        TabBarButton(activeView: $activeView, wentToStoreFromBathroom: $wentToStoreFromBathroom, background: $background, image: "sodacan", selectedTab: $selectedTab)
                        //TabBarButton(image: "message", selectedTab: $selectedTab)
                        TabBarButton(activeView: $activeView, wentToStoreFromBathroom: $wentToStoreFromBathroom, background: $background,image: "tennis", selectedTab: $selectedTab)
                        SettingsButton(activeView: $activeView, image: "gearkog", navigateToSettings: $navigateToSettings)
                        //MiniGameButton(activeView: $activeView, image: "1.circle", navigateToMiniGame: $navigateToMiniGame)
                        GraveyardButton(image: "tombstone", navigateToGraveyard: $navigateToGraveyard)

                    }
                    .background(Image("\(background)"))
                    .background(.white)

//                    .frame(height: (activeView != .bottom ? 100 : 100))
//                    .padding(.bottom, (activeView != .bottom ? 0 : 100))
                    
                    .cornerRadius(Constants.tabsCornerRadius, corners: [.topRight, .topLeft])
                    //.padding(.horizontal)
                    //.padding(.top, 100)
                }
                //.frame(height: (activeView != .bottom ? 100 : 500))
                .offset(y: (activeView != .bottom ? Constants.collapsedTabsYOffset : Constants.expandedTabsYOffset))
                testView
            }
        }
    }
    
    var backButton: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.red)
                .frame(width: 100, height: 100)
        }
        .padding(.top, 100)
    }
    
    var testView: some View {
        ZStack {
            
            
            Group {
                if selectedTab == "burger" {
                    VStack {
                        //Text("Food")
                        DisplayStoreProduct(storeItemsNameSpace: _storeItemsNameSpace, productType: .food)
                    }
                }
                else if selectedTab == "drink" {
                    VStack {
                        //Text("Beverages")
                        DisplayStoreProduct(storeItemsNameSpace: _storeItemsNameSpace, productType: .beverage)
                    }
                    
                }
                else if selectedTab == "tennis" {
                    VStack {
                        //Text("Toys")
                        DisplayStoreProduct(storeItemsNameSpace: _storeItemsNameSpace, productType: .toy)
                    }
                }
            }
            .padding(.top, 50)
            
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
                        background = "tabbar"
                    }
                } label: {
                    Text("Back to home")
                        .foregroundColor(.white)
                }
            }
            .font(Constants.storeMoneyFont)
            .padding(.bottom, 300)
        }
    }
    
//        switch selectedTab {
//            case "burger":
//                self.background = "tabbarfood_dark"
//        }
}

struct DisplayStoreProduct: View {
    
    @Namespace var storeItemsNameSpace
    
    @EnvironmentObject var viewModel: PetViewModel
    
    @State var productType: Item.types
    
    var body: some View {
        HStack {
            AspectVGrid(items: viewModel.store.products, aspectRatio: 2/3, content: { item in
                if item.type == productType {
                    StoreItem(withItem: item)
                        //.matchedGeometryEffect(id: item.id, in: storeItemsNameSpace)
                }
            })
        }
        .padding(.top, 200)
        //.padding(.leading, 10)
    }
}

struct StoreItem: View {
    @EnvironmentObject var viewModel: PetViewModel
    
    var withItem: Item
    
    var body: some View {
        Button {
            SoundManager.soundInstance.playSound(sound: .click)
            viewModel.store.buy(item: withItem)
            viewModel.saveData()
            print("You have bought \(withItem.name)!")
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.red)
                    .frame(width: Constants.storeItemsFrameWidth, height: Constants.storeItemsFrameHeight)
                HStack(spacing: 100) {
                    
                    VStack(spacing: 5) {
                        Text(withItem.name)
                        Text("+ \(Int(withItem.improveStatsBy))")
                        Text("Price: 💲\(withItem.price)")
                    }
                    .foregroundColor(.black)
                    .font(Constants.storeItemsFont)
                    Image(withItem.imageName)
                }
                
                
            }
        }
        .disabled(viewModel.store.money < withItem.price)

    }
}

struct TabBarButton: View {
    
    @Binding var activeView: currentView
    @Binding var wentToStoreFromBathroom: Bool
    @Binding var background: String
    
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
                    switch selectedTab {
                        case "burger":
                            background = "tabbarfood_dark"
                        case "drink":
                            background = "tabbardrink_dark"
                        case "tennis":
                            background = "tabbartoy_dark"
                        default:
                            background = "tabbar"
                    }
                }
                
            }) {
                Image("\(image)\(selectedTab == image ? "_dark" : "")")
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
                Image("\(image)")
                    .font(.system(size: 25, weight: .semibold))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: Constants.tabButtonsFrameHeight)
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
        .frame(height: Constants.tabButtonsFrameHeight)
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
                Image("\(image)")
                    .font(.system(size: 25, weight: .semibold))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: Constants.tabButtonsFrameHeight)
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


    

