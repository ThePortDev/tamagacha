//
//  PetViewModel.swift
//  tamagacha
//
//  Created by Porter Dover on 1/17/23.
//
// TODO: Reset Store when pet dies

import SwiftUI
import Foundation
import SpriteKit

class PetViewModel: ObservableObject {
    
    @Published var pet: Pet
    @Published var store: Store
    @Published var gameScene: GameScene
    
    //@Published var catchMiniGameScene: CatchMiniGameScene
    
    var onDeath: () -> Void = { }
    
    private(set) var userDefaultPet = PetUserDefaults()
    private var userDefaultStore = StoreUserDefaults()

    private var timer: Timer?
    
    init() {
        pet = userDefaultPet.loadData()
        store = userDefaultStore.loadData()
        
        gameScene = GameScene()
        //catchMiniGameScene = CatchMiniGameScene()
        
        gameScene.setup(with: self)
        //catchMiniGameScene.setup(with: self)
        
        // RoomView
        gameScene.size = CGSize(width: screenWidth, height: screenHeight)
        gameScene.scaleMode = .fill
        gameScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // CatchMiniGame
//        catchMiniGameScene.size = CGSize(width: screenWidth, height: screenHeight)
//        catchMiniGameScene.scaleMode = .fill
//        catchMiniGameScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        timer = Timer.scheduledTimer(withTimeInterval: Pet.saveRate, repeats: true) { _ in
            DispatchQueue.main.async {
                self.saveData()
                
            }
            self.store.add(money: 10)
        }
        timer = Timer.scheduledTimer(withTimeInterval: Pet.decreaseTime, repeats: true) { _ in
            self.pet.update()
            
            if !self.pet.isAlive {
                self.onDeath()
            }
//            SoundManager.soundInstance.playSound(sound: .chaching)
        }
    }
    
    func add(item: Item) {
        gameScene.add(item: item)
    }
    
    func goToShower() {
        gameScene.shower()
    }
    
    func tennisBallInteraction(toy: Item) { gameScene.tennisBallInteraction(toy: toy) }
    func ropeInteraction(toy: Item) { gameScene.ropeInteraction(toy: toy) }
    func stuffedToyInteraction(toy: Item) { gameScene.stuffedToyInteraction(toy: toy) }
    func tireInteraction(toy: Item) { gameScene.tireInteraction(toy: toy) }
    
    func getPetType() -> SKSpriteNode {
        switch pet.petType {
            case .dog:
                return SKSpriteNode(imageNamed: "dog")
            case .fish:
                return SKSpriteNode(imageNamed: "fish")
            case .cat:
                return SKSpriteNode(imageNamed: "cat")
            case .bird:
                return SKSpriteNode(imageNamed: "bird")
            case .slime:
                return SKSpriteNode(imageNamed: "slime")
        }
    }
    
    func saveData() {
        objectWillChange.send()
        userDefaultPet.saveData(pet: pet)
        userDefaultStore.saveData(store: self.store)
    }
    
    func feed(amount: CGFloat) {
        if pet.isAlive {
            pet.hunger += amount
            if pet.hunger >= pet.maxHunger {
                pet.hunger = pet.maxHunger
            }
            saveData()
        }
    }
    
    func giveWater(amount: CGFloat) {
        if pet.isAlive {
            pet.thirst += amount
            if pet.thirst >= pet.maxThirst {
                pet.thirst = pet.maxThirst
            }
            saveData()
        }
    }
    
    func petPet(amount: CGFloat) {
        if pet.isAlive {
            pet.love += amount
            if pet.love >= pet.maxLove {
                pet.love = pet.maxLove
            }
            saveData()
        }
    }
    
    func shower(amount: CGFloat) {
        if pet.isAlive {
            pet.hygiene += amount
            if pet.hygiene >= pet.maxHygiene {
                pet.hygiene = pet.maxHygiene
            }
            saveData()
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
