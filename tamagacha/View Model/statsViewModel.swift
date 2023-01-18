//
//  StatsViewModel.swift
//  tamagacha
//
//  Created by Porter Dover on 1/18/23.
//

import SwiftUI
import Foundation


struct StatsViewModel {
    
//    private var userDefaultTime: PetUserDefaults()
//
//    init() {
//        pet = userDefaultTime.loadData()
//    }
    
    var hungerPercent: CGFloat = 1.00 {
        willSet {
            if newValue <= 0 {
                petDead = true
            }
        }
    }
    var thirstPercent: CGFloat = 0.70 {
        willSet {
            if newValue <= 0 {
                petDead = true
            }
        }
    }
    var hygienePercent: CGFloat = 1.00 {
        willSet {
            if newValue <= 0 {
                petDead = true
            }
        }
    }
    var lovePercent: CGFloat = 1.00 {
        willSet {
            if newValue <= 0 {
                petDead = true
            }
        }
    }
    var energyPercent: CGFloat = 1.00 {
        willSet {
            if newValue <= 0 {
                petDead = true
            }
        }
    }
    
    var petDead: Bool = false
}
