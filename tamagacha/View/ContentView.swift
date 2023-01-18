//
//  ContentView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/17/23.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            Text("this is the menu i guess")
            NavigationView {
                NavigationLink("play") {
                    HomeView()
                }
            }
        }
        
        .padding()
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

//
//  StatView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/18/23.
//

import SwiftUI

struct StatView: View {
    
    var statsViewModel = StatsViewModel()
    @State var frame: CGSize = .zero
    
    var body: some View {
        List {
            VStack {
                waterBar
                foodBar
                loveBar
                hygieneBar
                energyBar
            }
        }
    }
    
    var waterBar: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.gray)
                .frame(width: 150)
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.blue)
                .frame(width: 150 * statsViewModel.thirstPercent)
            Text("Thirst: \(Double(statsViewModel.thirstPercent).formatted(.percent))")
        }
    }
    
    var foodBar: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.gray)
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.yellow)
                    .frame(width: geometry.size.width * statsViewModel.hungerPercent)
                Text("Hunger: \(Double(statsViewModel.hungerPercent).formatted(.percent))")
            }
        }
    }
    
    var energyBar: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.gray)
                .frame(width: 150)
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.cyan)
                .frame(width: 150 * statsViewModel.energyPercent)
            Text("Energy: \(Double(statsViewModel.energyPercent).formatted(.percent))")
        }
    }
    
    var loveBar: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.gray)
                .frame(width: 150)
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.red)
                .frame(width: 150 * statsViewModel.lovePercent)
            Text("Love: \(Double(statsViewModel.lovePercent).formatted(.percent))")
        }
    }
    
    var hygieneBar: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.gray)
                .frame(width: 150)
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.green)
                .frame(width: 150 * statsViewModel.hygienePercent)
            Text("Hygiene: \(Double(statsViewModel.hygienePercent).formatted(.percent))")
        }
    }
}

struct StatView_Previews: PreviewProvider {
    static var previews: some View {
        StatView()
    }
}

