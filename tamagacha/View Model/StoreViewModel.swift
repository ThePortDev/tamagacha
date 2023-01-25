//
//  StoreViewModel.swift
//  tamagacha
//
//  Created by Porter Dover on 1/23/23.
//

import Foundation

class StoreViewModel: ObservableObject {
    @Published var store: Store
    
    init() {
        store = Store() //userDefaltStore.loadData()
    }
    
    //MARK: Intents
    func buy(item: String) {
        store.buy(item: item)
    }
    func remove(item: String) {
        store.remove(item: item)
    }
    func add(money: Int) {
        store.add(money: money)
    }
}
