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
    
    var age: Int {
        let timeSince = calculateTimeSince(data: birthday)
        return timeSince
    }
    
    var happinessLevel: String {
        hunger == "Hungry" || thirst == "Thirsty" ? "Unhappy" : "Happy"
    }
    
    var hunger: String {
        let timeSince = calculateTimeSince(data: lastMeal)
        var string = ""
        
        switch timeSince {
            case 0..<30: string = "Not hungry"
            case 30..<60: string = "Getting hungry"
            case 60...: string = "Hungry"
            default: string = "IDK"
        }
        
        return string
    }
    
    var thirst: String {
        let timeSince = calculateTimeSince(data: lastMeal)
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
    
    func calculateTimeSince(data: Date) -> Int {
        let seconds = Int(-data.timeIntervalSinceNow)
        return seconds
    }
    
}
