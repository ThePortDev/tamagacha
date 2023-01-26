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
    
    var hunger: CGFloat
    var thirst: CGFloat
    var hygiene: CGFloat
    var love: CGFloat
    

    var maxHunger: CGFloat
    var maxThirst: CGFloat
    var maxHygiene: CGFloat
    var maxLove: CGFloat
    
    var description: String
    
    init(name: String, image: String, petType: PetType, maxHunger: CGFloat, hunger: CGFloat, maxThirst: CGFloat, thirst: CGFloat, maxHygiene: CGFloat, hygiene: CGFloat, maxLove: CGFloat, love: CGFloat, description: String) {
        self.name = name
        self.image = image
        self.petType = petType
        
        self.description = description
        
        self.lastUpdated = Date()
        
        self.hunger = hunger
        self.maxHunger = maxHunger
        
        self.thirst = thirst
        self.maxThirst = maxThirst
        
        self.hygiene = hygiene
        self.maxHygiene = maxHygiene
        
        self.love = love
        self.maxLove = maxLove
    }
    
    mutating func update() {
        if isAlive {
            hunger -= Pet.decreaseRate
            thirst -= Pet.decreaseRate
            hygiene -= Pet.decreaseRate
            love -= Pet.decreaseRate
            lastUpdated = Date()
            if hunger <= 0 || thirst <= 0 || hygiene <= 0 || love <= 0 {
                isAlive = false
            }
        }
    }
    
    
    var age: Int {
        let timeSince = calculateTimeSince(data: birthday)
        return timeSince
    }
    
    var lastUpdated: Date
    
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
    static var decreaseTime: CGFloat = 2
}
