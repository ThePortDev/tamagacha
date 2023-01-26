//
//  PetViewModel.swift
//  tamagacha
//
//  Created by Porter Dover on 1/17/23.
//

import SwiftUI
import Foundation
import SpriteKit

class PetViewModel: ObservableObject {
    
    @Published var pet: Pet

    @Published var store: Store
    
    @Published var gameScene: GameScene
    
    func add(item: Item) {
        gameScene.add(item: item)
    }
        
    private(set) var userDefaultPet = PetUserDefaults()
    private var userDefaultStore = StoreUserDefaults()

    private var timer: Timer?
    
    
    init() {
        print(userDefaultPet.loadData())
        pet = userDefaultPet.loadData()
        store = userDefaultStore.loadData()
        gameScene = GameScene()
        gameScene.setup(with: self)
        gameScene.size = CGSize(width: 400, height: 700)
        gameScene.scaleMode = .fill
        gameScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        timer = Timer.scheduledTimer(withTimeInterval: Pet.decreaseTime, repeats: true) { _ in
            self.pet.update()
            self.store.add(money: 1)
            DispatchQueue.main.async {
                self.saveData()
            }
        }
        
    }
    
    func getPetType() -> SKSpriteNode {
        switch pet.petType {
            case .dog:
                return SKSpriteNode(imageNamed: "TESTDOG")
            case .fish:
                return SKSpriteNode(imageNamed: "TESTFISH")
            case .cat:
                return SKSpriteNode(imageNamed: "TESTCAT")
            case .bird:
                return SKSpriteNode(imageNamed: "TESTBIRD")
            case .slime:
                return SKSpriteNode(imageNamed: "TESTSLIME")
        }
    }
    
    func saveData() {
        objectWillChange.send()
        userDefaultPet.saveData(pet: pet)
    }
    
    func feed(amount: CGFloat) {
        if pet.isAlive {
            pet.hunger += amount
            if pet.hunger >= pet.maxHunger {
                pet.hunger = pet.maxHunger
            }
        }
    }
    
    func giveWater(amount: CGFloat) {
        if pet.isAlive {
            pet.thirst += amount
            if pet.thirst >= pet.maxThirst {
                pet.thirst = pet.maxThirst
            }
        }
    }
    
    func petPet(amount: CGFloat) {
        if pet.isAlive {
            pet.love += amount
            if pet.love >= pet.maxLove {
                pet.love = pet.maxLove
            }
        }
    }
    
    func shower(amount: CGFloat) {
        if pet.isAlive {
            pet.hygiene += amount
            if pet.hygiene >= pet.maxHygiene {
                pet.hygiene = pet.maxHygiene
            }
        }
    }
    
    //MARK: Store Intents
    func buy(item: Item) {
        store.buy(item: item)
    }
    func remove(item: String) {
        store.remove(item: item)
    }
    func add(money: Int) {
        store.add(money: money)
    }
    
    deinit {
        timer?.invalidate()
    }
    
}
