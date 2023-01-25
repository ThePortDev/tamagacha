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
    
    @EnvironmentObject var viewModel: PetViewModel
    

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
}



struct HomeView2_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
