//
//  PetModel.swift
//  tamagacha
//
//  Created by Porter Dover on 1/17/23.
//

import Foundation

struct Pet: Codable {
    var name: String
    var birthday = Date()
    var isAlive = true
    
    var age: Int {
        let timeSince = calculateTimeSince(data: birthday)
        return timeSince
    }
    
    
    var hunger: CGFloat {
        let timeSince = calculateTimeSince(data: lastMeal)
        var hunger = 1.0
        
        if timeSince >= 1 {
            hunger -= 0.01
        }
        print(hunger)
        
        return hunger
    }
    
    
    var thirst: CGFloat {
        let timeSince = calculateTimeSince(data: lastDrink)
        var thirst = 1.0
        
        if timeSince >= 1 {
            thirst -= 0.01
        }
        
        return thirst
    }
    
    var hygiene: CGFloat {
        let timeSince = calculateTimeSince(data: lastShower)
        var hygiene = 1.0
        
        if timeSince >= 1 {
            hygiene -= 0.01
        }
        
        return hygiene
    }
    
    var love: CGFloat {
        let timeSince = calculateTimeSince(data: lastShownAffection)
        var love = 1.0
        
        if timeSince >= 1 {
            love -= 0.01
        }
        
        return love
    }
    
    var lastMeal: Date
    var lastDrink: Date
    var lastShower: Date
    var lastShownAffection: Date
    
   
    
    enum PetType {
        case dog
        case fish
        case cat
        case bird
        case slime
    }
    
    enum Emotions {
        case health
        case hunger
        case thirst
        case hygiene
        case love
    }
    
    
}
