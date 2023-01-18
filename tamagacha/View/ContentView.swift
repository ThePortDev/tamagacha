//
//  ContentView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/17/23.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            Text("this is the menu i guess")
            NavigationView {
                NavigationLink("play") {
                    HomeView()
                }
            }
        }
        
        .padding()
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

