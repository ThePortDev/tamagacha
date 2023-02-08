//
//  StoreModel.swift
//  tamagacha
//
//  Created by Porter Dover on 1/23/23.
//

import Foundation

struct Store: Codable {
    
    var products: [Item] = [Item(name: "Not Dog Food"), Item(name: "Lettuce"), Item(name: "Pizza"), Item(name: "Sandwich"), Item(name: "Milk"), Item(name: "Water"), Item(name: "Soda Can"), Item(name: "Margarita"), Item(name: "Tennis Ball"), Item(name: "Rope"), Item(name: "Stuffed Toy"), Item(name: "Tire"), Item(name: "Gun"), Item(name: "Beanie")] // items available to purchase and their price as an int
    
    var inventory = [Item: Int]() // items the user owns/has bought and the amount of that item they have
    
    var money: Int = 10

    init() {
        if self.inventory.isEmpty {
            for product in products {
                self.inventory[product] = 0
            }
            self.inventory[Item(name: "Not Dog Food")] = 1
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

struct Item: Hashable, Codable, Identifiable {
    var id: Int
    
    
    var name: String
    var imageName: String
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
        self.imageName = name.replacingOccurrences(of: " ", with: "").lowercased()
        switch self.name {
            case "Not Dog Food":
                self.type = .food; self.improveStatsBy = 10; self.price = 5; self.id = 0
            case "Lettuce":
                self.type = .food; self.improveStatsBy = 2; self.price = 1; self.id = 1
            case "Pizza":
                self.type = .food; self.improveStatsBy = 20; self.price = 10; self.id = 2
            case "Sandwich":
                self.type = .food; self.improveStatsBy = 40; self.price = 20; self.id = 3
            case "Milk":
                self.type = .beverage; self.improveStatsBy = 10; self.price = 5; self.id = 4
            case "Water":
                self.type = .beverage; self.improveStatsBy = 5; self.price = 3; self.id = 5
            case "Soda Can":
                self.type = .beverage; self.improveStatsBy = 20; self.price = 10; self.id = 6
            case "Margarita":
                self.type = .beverage; self.improveStatsBy = 40; self.price = 20; self.id = 7
            case "Tennis Ball":
                self.type = .toy; self.improveStatsBy = 5; self.price = 3; self.id = 8
            case "Rope":
                self.type = .toy; self.improveStatsBy = 10; self.price = 5; self.id = 9
            case "Stuffed Toy":
                self.type = .toy; self.improveStatsBy = 20; self.price = 10; self.id = 10
            case "Tire":
                self.type = .toy; self.improveStatsBy = 30; self.price = 15; self.id = 11
            case "Gun":
                self.type = .toy; self.improveStatsBy = 40; self.price = 20; self.id = 12
            case "Beanie":
                self.type = .accessory; self.improveStatsBy = 0; self.price = 4; self.id = 13
            default:
                self.type = .error; self.improveStatsBy = 0; self.price = 0; self.id = 14
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
