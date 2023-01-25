//
//  StoreModel.swift
//  tamagacha
//
//  Created by Porter Dover on 1/23/23.
//

import Foundation

struct Store {
    
    var products: [Item: Int] = [Item(name: "Dog Food"): 1, Item(name: "Milk"): 2, Item(name: "Tennis Ball"): 3, Item(name: "Beanie"): 4] // items available to purchase and their price as an int
    
    var inventory = [Item: Int]() // items the user owns/has bought and the amount of that item they have
    
    var money: Int = 10

    init() {
        for product in products.keys {
            self.inventory[product] = 0
        }
        self.inventory[Item(name: "Dog Food")] = 1
    }
    
    mutating func buy(item: String) {
        for product in products {
            if product.key.name == item && money >= product.value {
                inventory[Item(name: item)]! += 1
                money -= product.value
            }
        }
    }
    
    mutating func remove(item: String) {
        for (key, _) in inventory {
            if key.name == item {
                inventory[key]! -= 1
            }
        }
    }
    
    mutating func add(money: Int) {
        self.money += money
    }
}

struct Item: Hashable {
    
    var name: String
    
    var type: types {
        switch self.name {
            case "Dog Food":
                return .food
            case "Milk":
                return .beverage
            case "Tennis Ball":
                return .toy
            case "Beanie":
                return .accessory
            default:
                return .food
        }
    }
    
    enum types: Codable {
        case food      // hunger
        case beverage  // thirst
        case toy       // love
        case accessory // cosmetic/nothing
    }

    
    init(name: String) {
        self.name = name
    }
}
