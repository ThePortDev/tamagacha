//
//  BathroomView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/19/23.
//

import SwiftUI

struct BathroomView: View {
    @Binding var activeView: currentView
    
    var body: some View {
        HStack {
            GeometryReader { geometry in
                HStack {
                    ZStack {
                        Rectangle()
                            .cornerRadius(20, corners: [.topRight, .bottomRight])
                            .foregroundColor(.purple)
                        Text("Bathroom")
                    }
                    //.background(Color.purple)
                    .edgesIgnoringSafeArea(.all)
                    //RoundedRectangle(cornerRadius: 10)
                    if activeView == .center {
                        ZStack {
                            Rectangle().cornerRadius(20, corners: [.topRight, .bottomRight])
                                .frame(width: 40, height: 80)
                            Text("🛀")
                        }
                    } else {
                        Rectangle().cornerRadius(20, corners: [.topRight, .bottomRight])
                            .frame(width: 40, height: 80)
                            .foregroundColor(.red)
                    }
                }
            }
            
            
        }
        
    }
}

