//
//  RoundedRectangle.swift
//  tamagacha
//
//  Created by Porter Dover on 1/19/23.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct CoolRect: View {
    let text: String
    let gradientColors: [Color]
    var body: some View {
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 100, height: 100))
                .fill(AngularGradient(colors: gradientColors, center: .topLeading))
                .frame(width: 180, height: 35)
                .shadow(
                    color: .black.opacity(0.5),
                    radius: 10,
                    x:0.0, y:10
                )
            Text(text)
                .foregroundColor(.black)
                .bold()
        }
    }
}
