//
//  tamagachaApp.swift
//  tamagacha
//
//  Created by Porter Dover on 1/17/23.
//

import SwiftUI

@main
struct tamagachaApp: App {
    
    @Environment(\.scenePhase) var phase
    
    @StateObject var viewModel = PetViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MenuView()
            }
            .environmentObject(viewModel)
        }
        .onChange(of: phase) { newPhase in
            switch newPhase {
                case .background: viewModel.saveData(); print("is in background")
                case .inactive: viewModel.saveData(); print("is inactive")
                case .active: print("Game is Active")
                @unknown default:
                    fatalError()
            }
        }
    }
}
