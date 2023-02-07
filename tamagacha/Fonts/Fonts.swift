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
    
    static func oldSchoolAdventures(size: CGFloat, relativeTo style: TextStyle = .body) -> Font {
        custom("Old School Adventures", size: size, relativeTo: style)
    }
    
    static func yoster(size: CGFloat, relativeTo style: TextStyle = .body) -> Font {
        custom("Yoster Island", size: size, relativeTo: style)
    }
}

enum TamagachaFont {
    static let title = Font.hangTheDj(size: 30, relativeTo: .title)
}

enum ThemeColors {
    static let primary = Color("primary")
    static let accent = Color("accent")
    static let accentVariant = Color("accentVariant")
    static let primaryText = Color("primaryText")
    static let accentText = Color("accentText")
}
