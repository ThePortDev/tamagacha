//
//  StoreView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/19/23.
//

import SwiftUI

struct StoreView: View {
    @Binding var activeView: currentView
    @Binding var wentToStoreFromBathroom: Bool
    
    @Binding var navigateToSettings: Bool
    @Binding var navigateToMiniGame: Bool
    @Binding var navigateToGraveyard: Bool
    
    @State var selectedTab = ""
    
    @EnvironmentObject var viewModel: PetViewModel
    
    var buttons = ["house", "bookmark", "sportscourt", "gearshape"]
    

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                //storeSwipeTab
                //storeTapTab
                CustomTabBar(activeView: $activeView, wentToStoreFromBathroom: $wentToStoreFromBathroom, selectedTab: $selectedTab, navigateToSettings: $navigateToSettings, navigateToMiniGame: $navigateToMiniGame, navigateToGraveyard: $navigateToGraveyard)
            }
            //.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
//        .edgesIgnoringSafeArea(.all)
        
    }


}



struct HomeView2_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(DeadPetsVM: DeadPetUserDefaults())
    }
}
