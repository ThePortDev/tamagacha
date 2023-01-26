//
//  TabBar.swift
//  tamagacha
//
//  Created by Porter Dover on 1/25/23.
//

import SwiftUI

struct CustomTabBar: View {
    
    @EnvironmentObject var viewModel: PetViewModel
    
    @Binding var selectedTab: String
    @Binding var navigateToSettings: Bool
        
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .frame(width: screenWidth, height: 900)
                .foregroundColor(.blue)
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    HStack(spacing: 0) {
                        TabBarButton(image: "house", selectedTab: $selectedTab)
                        TabBarButton(image: "bookmark", selectedTab: $selectedTab)
                        //TabBarButton(image: "message", selectedTab: $selectedTab)
                        TabBarButton(image: "sportscourt", selectedTab: $selectedTab)
                        SettingsButton(image: "gearshape", navigateToSettings: $navigateToSettings)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30, corners: [.topRight, .topLeft])
                    .padding(.horizontal)
                    .padding(.top, 100)
                }
                Text("Money: $\(viewModel.store.money)")
                testView
            }
        }
    }
    
    var testView: some View {
        ZStack {
            if selectedTab == "house" {
                VStack {
                    Text("Food")
                    DisplayStoreProduct(productType: .food)
                }
            }
            else if selectedTab == "bookmark" {
                VStack {
                    Text("Beverages")
                    DisplayStoreProduct(productType: .beverage)
                }
                
            }
            else if selectedTab == "message" {
                VStack {
                    Text("Accessories")
                    DisplayStoreProduct(productType: .accessory)
                }
            }
            else if selectedTab == "sportscourt" {
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
            ForEach(Array(viewModel.store.products.keys), id: \.self) { item in
                if productType == item.type {
                    SubView(withItem: item)
                }
            }
        }
    }
}

struct SubView: View {
    @EnvironmentObject var viewModel: PetViewModel

    var withItem: Item
    
    var body: some View {
        GeometryReader { geometry in
            Button {
                viewModel.store.buy(item: withItem.name)
                print("You have bought \(withItem.name)!")
            } label: {
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.red)
                    .frame(width: 100, height: 100)
                VStack {
                    Text(withItem.name)
                    Text("+ \(Int(withItem.improveStatsBy))")
                    Text("Price: $\(viewModel.store.products[withItem] ?? 0)")
                }
            }
        }
        }
    }
}

struct TabBarButton: View {
    var image: String
    @Binding var selectedTab: String
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                withAnimation {
                    selectedTab = image
                }
            }) {
                Image(systemName: "\(image)\(selectedTab == image ? ".fill" : "")")
                    .font(.system(size: 25, weight: .semibold))
                    .offset(y: selectedTab == image ? -10 : 0)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 50)
    }
}

struct SettingsButton: View {
    var image: String
    @Binding var navigateToSettings: Bool
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                navigateToSettings = true
            }) {
                Image(systemName: "\(image)")
                    .font(.system(size: 25, weight: .semibold))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 50)
    }
}

struct HomeView4_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
