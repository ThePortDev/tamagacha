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
    @Binding var navigateToToyChest: Bool
    @Binding var navigateToKitchen: Bool

    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                ZStack {
                        
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.red)
                        
                        VStack {
                            if activeView == .center {
                                Image(systemName: "chevron.up")
                                Text("Store")
                                    .padding(.top)
                                    .padding(.bottom, 650)
                            }
                            HStack {
                                
                                Button("Kitchen") {
                                    navigateToKitchen = true
                                }
                                Button("Toychest") {
                                    navigateToToyChest = true
                                }
                                Button("Settings") {
                                    navigateToSettings = true
                                }
                                
                            }
                            .frame(width: 100, height: 100, alignment: .top)                            
                        }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
        .edgesIgnoringSafeArea(.all)
        
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
