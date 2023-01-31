//
//  StoreModel.swift
//  tamagacha
//
//  Created by Porter Dover on 1/23/23.
//

import Foundation

struct Store: Codable {
    
    var products: [Item] = [Item(name: "Dog Food"), Item(name: "Milk"), Item(name: "Tennis Ball"), Item(name: "Beanie")] // items available to purchase and their price as an int
    
    var inventory = [Item: Int]() // items the user owns/has bought and the amount of that item they have
    
    var money: Int = 10

    init() {
        if self.inventory.isEmpty {
            for product in products {
                self.inventory[product] = 0
            }
            self.inventory[Item(name: "Dog Food")] = 1
        }
    }
    
    mutating func buy(item: Item) {
        for product in products {
            if product.name == item.name && money >= product.price {
                inventory[item]! += 1
                money -= product.price
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

struct Item: Hashable, Codable {
    
    var name: String
    var improveStatsBy: CGFloat
    var price: Int
    var type: types
    
    enum types: Codable {
        case food      // hunger
        case beverage  // thirst
        case toy       // love
        case accessory // cosmetic/nothing
        case error
    }

    
    init(name: String) {
        self.name = name
        switch self.name {
            case "Dog Food":
                self.type = .food; self.improveStatsBy = 10; self.price = 1
            case "Milk":
                self.type = .beverage; self.improveStatsBy = 5; self.price = 2
            case "Tennis Ball":
                self.type = .toy; self.improveStatsBy = 3; self.price = 3
            case "Beanie":
                self.type = .accessory; self.improveStatsBy = 0; self.price = 4
            default:
                self.type = .error; self.improveStatsBy = 0; self.price = 0
        }
    }
}

class StoreUserDefaults {
    var storeKey = "STORE_KEY"
    var store: Store
    
    init() {
        if let data = UserDefaults.standard.data(forKey: storeKey) {
            if let decoded = try? JSONDecoder().decode(Store.self, from: data) {
                self.store = decoded
                print("Store data successfully retrieved!")
                return
            }
        }

        self.store = Store()
    }
    
    func loadData() -> Store {
        return self.store
    }
    
    func saveData(store: Store) {
        if let encoded = try? JSONEncoder().encode(store) {
            UserDefaults.standard.set(encoded, forKey: storeKey)
            
            print("Store Data saved at: \(Date().formatted(date: .omitted, time: .standard))")
        }
    }
}
