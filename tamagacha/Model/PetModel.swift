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
    
    
    var thirst: String {
        let timeSince = calculateTimeSince(data: lastDrink)
        var string = ""
        
        switch timeSince {
            case 0..<30: string = "Not thirsty"
            case 30..<60: string = "Getting thirsty"
            case 60...: string = "Thirsty"
            default: string = "IDK"
        }
        
        return string
    }
    
    var lastMeal: Date
    var lastDrink: Date
    var hygiene: Date
    
    mutating func takeShower() {
        hygiene += 50
    }
    
    enum PetType {
        case dog
        case fish
        case cat
        case bird
    }
    
    enum Emotions {
        case health
        case hunger
        case thirst
        case hygiene
        case love
    }
    
    
}
