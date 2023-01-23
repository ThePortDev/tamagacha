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
                }
            }
            //.frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
        }
//        .edgesIgnoringSafeArea(.all)
        
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
