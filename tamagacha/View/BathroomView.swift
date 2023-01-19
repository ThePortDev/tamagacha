//
//  BathroomView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/19/23.
//

import SwiftUI

struct BathroomView: View {
    @State var activeView: currentView
    
    var body: some View {
        GeometryReader { geometry in
            Text("Bathroom")
                .frame(width: screenSize.size.width, height: screenSize.size.height, alignment: .center)
        }
        .background(Color.purple)
        .edgesIgnoringSafeArea(.all)
    }
}
