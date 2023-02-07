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
                        TabBarButton(activeView: $activeView, wentToStoreFromBathroom: $wentToStoreFromBathroom, image: "burger", selectedTab: $selectedTab)
                        TabBarButton(activeView: $activeView, wentToStoreFromBathroom: $wentToStoreFromBathroom, image: "drink", selectedTab: $selectedTab)
                        //TabBarButton(image: "message", selectedTab: $selectedTab)
                        TabBarButton(activeView: $activeView, wentToStoreFromBathroom: $wentToStoreFromBathroom,image: "tennis", selectedTab: $selectedTab)
                        SettingsButton(activeView: $activeView, image: "gearkog", navigateToSettings: $navigateToSettings)
                        //MiniGameButton(activeView: $activeView, image: "1.circle", navigateToMiniGame: $navigateToMiniGame)
                        GraveyardButton(image: "tombstone", navigateToGraveyard: $navigateToGraveyard)

                    }
                    .background(Image("testback"))
                    .background(.white)
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

            if selectedTab == "burger" {
                VStack {
                    Text("Food")
                    DisplayStoreProduct(productType: .food)
                }
            }
            else if selectedTab == "drink" {
                VStack {
                    Text("Beverages")
                    DisplayStoreProduct(productType: .beverage)
                }
                
            }
            else if selectedTab == "tennis" {
                VStack {
                    Text("Accessories")
                    DisplayStoreProduct(productType: .accessory)
                }
            }
            else if selectedTab == "tennis" {
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
                Image("\(image)")
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
    
