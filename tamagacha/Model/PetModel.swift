//
//  PetModel.swift
//  tamagacha
//
//  Created by Porter Dover on 1/17/23.
//

import Foundation

struct Pet: Codable, Identifiable {
    var name: String
    var image: String
    var birthday = Date()
    var id = UUID()
    var isAlive: Bool
    var petStatus: String {
        if self.hunger > 75 && self.thirst > 75 && self.hygiene > 75 && self.love > 75 {
            return "Your pet is well taken care of right now!"
        }
        if self.hunger > 50 && self.thirst > 50 && self.hygiene > 50 && self.love > 50 {
            return "Your pet could use some care right about now."
        }
        if self.hunger > 25 && self.thirst > 25 && self.hygiene > 25 && self.love > 25 {
            return "Your pet is going to die if you don't help it soon. You monster."
        }
        if self.hunger > 10 && self.thirst > 10 && self.hygiene > 10 && self.love > 10 {
            return "\"Some People\" shouldn't be allowed to own pets..."
        }
        return "Your pet could use some help in some places."
    }
    
    var hunger: CGFloat
    var thirst: CGFloat
    var hygiene: CGFloat
    var love: CGFloat
    

    var maxHunger: CGFloat
    var maxThirst: CGFloat
    var maxHygiene: CGFloat
    var maxLove: CGFloat
    
    var description: String
    
    init(name: String, image: String, petType: PetType, maxHunger: CGFloat, hunger: CGFloat, maxThirst: CGFloat, thirst: CGFloat, maxHygiene: CGFloat, hygiene: CGFloat, maxLove: CGFloat, love: CGFloat, description: String, deadPets: [Pet] = [], isAlive: Bool =  true) {
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
        
        self.isAlive = isAlive
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
    static var decreaseTime: CGFloat = 300
    static var saveRate: CGFloat = 15
}
