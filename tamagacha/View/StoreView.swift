//
//  StoreView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/19/23.
//

import SwiftUI

struct StoreView: View {
    @Binding var activeView: currentView
    @Binding var navigateToSettings: Bool
        
    @State var selectedTab = "house"
    
    @EnvironmentObject var storeViewModel: StoreViewModel
    

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                storeSwipeTab
                CustomTabBar(selectedTab: $selectedTab, navigateToSettings: $navigateToSettings)
            }
            //.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
//        .edgesIgnoringSafeArea(.all)
        
    }
    
    var storeSwipeTab: some View {
        ZStack {
            Rectangle()
                .cornerRadius(90, corners: [.topLeft, .topRight])
                .frame(width: screenWidth, height: 100)
                .foregroundColor(.blue)
            VStack {
                Image(systemName: "chevron.up")
                Text("Store")
            }
        }
    }
    
    var oldStoreView: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .cornerRadius(90, corners: [.topLeft, .topRight])
                    .frame(width: screenWidth, height: 100)
                    .foregroundColor(.blue)
                VStack {
                    Image(systemName: "chevron.up")
                    Text("Store")
                }
            }
            ZStack {
                    
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.red)
                        .edgesIgnoringSafeArea(.all)

                        HStack {

                            Text("Kitchen")
                            Text("Toys")
                            Button("Settings") {
                                navigateToSettings = true
                            }

                        }
            }
        }
    }
}

struct CustomTabBar: View {
    
    @EnvironmentObject var storeViewModel: StoreViewModel
    
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
                        SettingsButton(image: "gearshape", navigateToSettings: $navigateToSettings)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(30, corners: [.topRight, .topLeft])
                    .padding(.horizontal)
                    .padding(.top, 100)
                }
                testView
            }
        }
    }
    
    var testView: some View {
        ZStack {
            if selectedTab == "house" {
                Rectangle()
                    .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
                    .padding(.horizontal)
                    .padding(.bottom)
                    .foregroundColor(.green)
                Text("Food")
                    .frame(width: .infinity,height: .infinity, alignment: .topTrailing)
            }
            else if selectedTab == "bookmark" {
                ZStack(alignment: .center) {
                    Rectangle()
                        .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
                        .padding(.horizontal)
                        .padding(.bottom)
                        .foregroundColor(.yellow)
                    Text("\(storeViewModel.store.money)")
                        .padding(.bottom, 100)
                    Button("Add Money") {
                        storeViewModel.add(money: 1)
                    }
                    .frame(width: 100, height: 100, alignment: .center)
                }
                
            }
            else if selectedTab == "message" {
                Rectangle()
                    .cornerRadius(30, corners: [.bottomLeft, .bottomRight])
                    .padding(.horizontal)
                    .padding(.bottom)
                    .foregroundColor(.red)
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


struct HomeView2_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
