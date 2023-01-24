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
    
    var hunger: CGFloat
    var thirst: CGFloat
    var hygiene: CGFloat
    var love: CGFloat
    
    var maxHunger: CGFloat
    var maxThirst: CGFloat
    var maxHygiene: CGFloat
    var maxLove: CGFloat
    
    init(name: String, lastMeal: Date, lastDrink: Date, lastShower: Date, lastShownAffection: Date, petType: PetType, maxHunger: CGFloat, maxThirst: CGFloat, maxHygiene: CGFloat, maxLove: CGFloat) {
        self.name = name
        self.petType = petType
        
        self.lastMeal = lastMeal
        self.lastDrink = lastDrink
        self.lastShower = lastShower
        self.lastShownAffection = lastShownAffection
        
        self.hunger = maxHunger
        self.maxHunger = maxHunger
        
        self.thirst = maxThirst
        self.maxThirst = maxThirst
        
        self.hygiene = maxHygiene
        self.maxHygiene = maxHygiene
        
        self.love = maxLove
        self.maxLove = maxLove
    }
    
    mutating func update() {
        if isAlive {
            hunger -= Pet.decreaseRate
            thirst -= Pet.decreaseRate
            hygiene -= Pet.decreaseRate
            love -= Pet.decreaseRate
            if hunger <= 0 || thirst <= 0 || hygiene <= 0 || love <= 0 {
                isAlive = false
            }
        }
    }
    
    
    var age: Int {
        let timeSince = calculateTimeSince(data: birthday)
        return timeSince
    }
    
    var lastMeal: Date
    var lastDrink: Date
    var lastShower: Date
    var lastShownAffection: Date
    var petType: PetType
    
   
    
    enum PetType: Codable {
        case dog
        case fish
        case cat
        case bird
        case slime
    }
    
    enum Emotions: Codable {
        case health
        case hunger
        case thirst
        case hygiene
        case love
    }
    
    
}

extension Pet {
    static var decreaseRate: CGFloat = 1
    static var decreaseTime: CGFloat = 1
}
