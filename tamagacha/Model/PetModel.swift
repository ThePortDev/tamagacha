//
//  PetModel.swift
//  tamagacha
//
//  Created by Porter Dover on 1/17/23.
//

import Foundation

struct Pet: Codable {
    var name: String
    var image: String
    var birthday = Date()
    var isAlive = true
    
    private var _hunger: CGFloat = 1.00
    private var _thirst: CGFloat = 1.00
    private var _hygiene: CGFloat = 1.00
    private var _love: CGFloat = 1.00
    
    init(name: String, image: String, lastMeal: Date, lastDrink: Date, lastShower: Date, lastShownAffection: Date) {
        self.name = name
        self.image = image
        self.lastMeal = lastMeal
        self.lastDrink = lastDrink
        self.lastShower = lastShower
        self.lastShownAffection = lastShownAffection
    }
    
    
    var age: Int {
        let timeSince = calculateTimeSince(data: birthday)
        return timeSince
    }
    
    
    var hunger: CGFloat {
        get {
            let timeSince = calculateTimeSince(data: lastMeal)
            var hunger = 1.0
            
            if timeSince >= 1 {
                hunger -= 0.01
            }
            print(hunger)
            
            return hunger
        }
        set {
            _hunger = newValue
        }
    }
    
    
    var thirst: CGFloat {
        get {
            let timeSince = calculateTimeSince(data: lastDrink)
            var thirst = 1.0
            
            if timeSince >= 1 {
                thirst -= 0.01
            }
            
            return thirst
        }
        set {
            _thirst = newValue
        }
    }
    
    var hygiene: CGFloat {
        get {
            let timeSince = calculateTimeSince(data: lastShower)
            var hygiene = 1.0
            
            if timeSince >= 1 {
                hygiene -= 0.01
            }
            
            return hygiene
        }
        set {
            _hygiene = newValue
        }
    }
    
    var love: CGFloat {
        get {
            let timeSince = calculateTimeSince(data: lastShownAffection)
            var love = 1.0
            
            if timeSince >= 1 {
                love -= 0.01
            }
            
            return love
        }
        set {
            _love = newValue
        }
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
