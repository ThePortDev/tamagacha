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
        
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                //.ignoresSafeArea()
                .frame(width: screenWidth, height: screenHeight)
                .foregroundColor(.blue)
                .offset(y: 154)
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    HStack(spacing: 0) {
                        TabBarButton(activeView: $activeView, wentToStoreFromBathroom: $wentToStoreFromBathroom, image: "house", selectedTab: $selectedTab)
                        TabBarButton(activeView: $activeView, wentToStoreFromBathroom: $wentToStoreFromBathroom, image: "bookmark", selectedTab: $selectedTab)
                        //TabBarButton(image: "message", selectedTab: $selectedTab)
                        TabBarButton(activeView: $activeView, wentToStoreFromBathroom: $wentToStoreFromBathroom,image: "sportscourt", selectedTab: $selectedTab)
                        SettingsButton(activeView: $activeView, image: "gearshape", navigateToSettings: $navigateToSettings)
                        //MiniGameButton(activeView: $activeView, image: "1.circle", navigateToMiniGame: $navigateToMiniGame)
                        GraveyardButton(image: "🪦", navigateToGraveyard: $navigateToGraveyard)

                    }
                    .background(Constants.tabsBackgroundColor)
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
            .font(Constants.storeMoneyFont)

            if selectedTab == "house" {
                VStack {
                    Text("Food")
                    DisplayStoreProduct(storeItemsNameSpace: _storeItemsNameSpace, productType: .food)
                }
            }
            else if selectedTab == "bookmark" {
                VStack {
                    Text("Beverages")
                    DisplayStoreProduct(storeItemsNameSpace: _storeItemsNameSpace, productType: .beverage)
                }
                
            }
            else if selectedTab == "message" {
                VStack {
                    Text("Accessories")
                    DisplayStoreProduct(storeItemsNameSpace: _storeItemsNameSpace, productType: .accessory)
                }
            }
            else if selectedTab == "sportscourt" {
                    VStack {
                        Text("Toys")
                        DisplayStoreProduct(storeItemsNameSpace: _storeItemsNameSpace, productType: .toy)
                    }
            }
        }
    }
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
                        .matchedGeometryEffect(id: item.id, in: storeItemsNameSpace)
                        .padding(.horizontal)
                }
            })
            .padding(.horizontal)
        }
        .padding(.top, 200)
        .padding(.leading, 10)
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
                VStack {
                    Text(withItem.name)
                    Text("+ \(Int(withItem.improveStatsBy))")
                    Text("Price: 💲\(withItem.price)")
                }
                .font(Constants.storeItemsFont)
                
            }
        }
        .disabled(viewModel.store.money < withItem.price)

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
                Image(systemName: "\(image)\(selectedTab == image ? ".fill" : "")")
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
                Image(systemName: "\(image)")
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
                Text(image)
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


    
struct AspectVGrid<Item, ItemView>: View where ItemView: View, Item: Identifiable {
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    init(items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                let width: CGFloat = widthThatFits(itemCount: items.count, in: geometry.size, itemAspetRatio: aspectRatio)
                LazyVGrid(columns: [adaptiveGridItem(width: width)]) {
                    ForEach(items) { item in
                        content(item).aspectRatio(aspectRatio, contentMode: .fit)
                        
                    }
                }
                Spacer(minLength: 0)
            }
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private func widthThatFits(itemCount: Int, in size: CGSize, itemAspetRatio: CGFloat) -> CGFloat {
            var columnCount = 1
            var rowCount = itemCount
            repeat {
                let itemWidth = size.width / CGFloat(columnCount)
                let itemHeight = itemWidth / itemAspetRatio
                if CGFloat(rowCount) * itemHeight < size.height {
                    break
                }
                columnCount += 1
                rowCount = (itemCount + (columnCount - 1)) / columnCount
            } while columnCount < itemCount
            if columnCount > itemCount {
                columnCount = itemCount
            }
            return floor(size.width / CGFloat(columnCount))
        }
}
