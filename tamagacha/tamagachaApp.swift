//
//  tamagachaApp.swift
//  tamagacha
//
//  Created by Porter Dover on 1/17/23.
//

import SwiftUI

@main
struct tamagachaApp: App {
    
    @StateObject var viewModel = PetViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MenuView()
            }
            .environmentObject(viewModel)
        }
    }
}
