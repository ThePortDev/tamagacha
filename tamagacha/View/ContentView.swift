//
//  ContentView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/17/23.
//

import SwiftUI

struct MenuView: View {
    @State var navigateToHomeView = false
    
    var body: some View {
        ZStack {
            Text("Tamagacha")
        }
        .background(
            Image("cheesepuffs")
                .resizable()
                .frame(width: screenWidth, height: screenHeight)
        )
        .onTapGesture {
            navigateToHomeView = true
        }
        .navigate(to: HomeView(), when: $navigateToHomeView)

    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

