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

            GeometryReader { geometry in
                HStack(spacing: 0) {
                    ZStack {
                        Rectangle()
                            .cornerRadius(20, corners: [.topRight, .bottomRight])
                            .foregroundColor(.purple)
                        Text("Bathroom")
                    }
                    //.background(Color.purple)
                    .edgesIgnoringSafeArea(.all)
                    if activeView != .bottom {
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

struct HomeView3_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
