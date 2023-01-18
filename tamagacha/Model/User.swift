//
//  User.swift
//  tamagacha
//
//  Created by Payton Gunnell on 1/17/23.
//

import Foundation

struct User {
    
    var exp: Int = 0
    var money: Int = 100
    //var pets: [Pet]
    
    
    mutating func addExp(amount: Int) {
        exp += amount
    }
    mutating func addMoney(amount: Int) {
        money += amount
    }
    mutating func subtractMoney(amount: Int) {
        money -= amount
    }
}
