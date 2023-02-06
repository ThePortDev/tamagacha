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
    @Binding var navigateToMiniGame: Bool
    @Binding var navigateToGraveyard: Bool
    
    @State var selectedTab = "house"
    
    @EnvironmentObject var viewModel: PetViewModel
    
    var buttons = ["house", "bookmark", "sportscourt", "gearshape"]
    

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                //storeSwipeTab
                //storeTapTab
                CustomTabBar(activeView: $activeView, selectedTab: $selectedTab, navigateToSettings: $navigateToSettings, navigateToMiniGame: $navigateToMiniGame, navigateToGraveyard: $navigateToGraveyard)
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

    var storeTapTab: some View {
        ZStack {
            Rectangle()
                .cornerRadius(90, corners: [.topLeft, .topRight])
                .frame(width: screenWidth, height: 100)
                .foregroundColor(.white)
            HStack {
                ForEach(buttons, id: \.self) { button in
                    Button {
                        withAnimation(.linear(duration: 1)) {
                            selectedTab = button
                            activeView = .bottom
                        }
                    } label: {
                        Image(systemName: button)
                    }
                }
            }
        }
    }
}



struct HomeView2_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
