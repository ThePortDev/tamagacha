//
//  Fonts.swift
//  tamagacha
//
//  Created by Hafa Bonati on 1/30/23.
//

import Foundation
import SwiftUI

extension Font {
    static func hangTheDj(size: CGFloat, relativeTo style: TextStyle = .body) -> Font {
        custom("HangTheDJ", size: size, relativeTo: style)
    }
}

enum TamagachaFont {
    static let title = Font.hangTheDj(size: 30, relativeTo: .title)
}
