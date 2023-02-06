//
//  DeveloperToolsView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/19/23.
//

import SwiftUI

struct DeveloperToolsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var viewModel: PetViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.black, .white, .white], startPoint: .bottomLeading, endPoint: .topTrailing)
                .ignoresSafeArea()
            VStack {
                Text("Developer Tools")
                    .foregroundColor(Defaults.textColor)
                    .bold()
                    .font(.custom("Yoster Island", size: 35))
                    .frame(alignment: .top)
                    .padding()
                changePetButtons
                addMoneyButtons
                misc
                Spacer()
                back
            }
        }
    }
    
    var back: some View {
        VStack {
            Button() {
                SoundManager.soundInstance.playSound(sound: .click)
                presentationMode.wrappedValue.dismiss()
            } label: {
                CoolRect(text: "Return", gradientColors: [.white, .black])
            }
        }
    }
    
    var misc: some View {
        VStack {
            Text("Miscallaneous:")
                .foregroundColor(Defaults.textColor)
                .bold()
                .font(.custom("Yoster Island", size: 25))
                .frame(alignment: .top)
                .padding()
            Button() {
                SoundManager.soundInstance.playSound(sound: .click)
                viewModel.pet.love = 1
                viewModel.saveData()
                print(viewModel.pet.isAlive)
            } label: {
                CoolRect(text: "Kill Pet", gradientColors: [.red, .black])
            }
            .padding()
            Button() {
                SoundManager.soundInstance.playSound(sound: .click)
                viewModel.pet.name = "Pikachan"
                viewModel.pet.image = "pikachan"
                viewModel.saveData()
            } label: {
                CoolRect(text: "Be The Very Best", gradientColors: [.white, .yellow, .white, .white, .red])
            }
        }
    }
    
    var addMoneyButtons: some View {
        VStack {
            Text("Add Money:")
                .foregroundColor(Defaults.textColor)
                .bold()
                .font(.custom("Yoster Island", size: 25))
                .frame(alignment: .top)
                .padding()
            HStack {
                Button() {
                    SoundManager.soundInstance.playSound(sound: .click)
                    viewModel.store.add(money: 250)
                    viewModel.saveData()
                } label: {
                    CoolRect(text: "250", gradientColors: [.green, .yellow])
                }
                Button() {
                    SoundManager.soundInstance.playSound(sound: .click)
                    viewModel.store.add(money: 500)
                    viewModel.saveData()
                } label: {
                    CoolRect(text: "500", gradientColors: [.green, .yellow])
                }
            }
            HStack {
                Button() {
                    SoundManager.soundInstance.playSound(sound: .click)
                    viewModel.store.add(money: 1000)
                    viewModel.saveData()
                } label: {
                    CoolRect(text: "1000", gradientColors: [.green, .yellow])
                }
                Button() {
                    SoundManager.soundInstance.playSound(sound: .click)
                    viewModel.store.add(money: 2000)
                    viewModel.saveData()
                } label: {
                    CoolRect(text: "2000", gradientColors: [.green, .yellow])
                }
            }
        }
    }
    
    var changePetButtons: some View {
        VStack {
            Text("Change Pet Type:")
                .foregroundColor(Defaults.textColor)
                .bold()
                .font(.custom("Yoster Island", size: 25))
                .frame(alignment: .top)
                .padding()
            HStack {
                Button() {
                    SoundManager.soundInstance.playSound(sound: .click)
                    viewModel.pet.petType = .dog
                    viewModel.saveData()
                } label: {
                    CoolRect(text: "Dog", gradientColors: [.brown, .black])
                }
                Button() {
                    SoundManager.soundInstance.playSound(sound: .click)
                    viewModel.pet.petType = .cat
                    viewModel.saveData()
                } label: {
                    CoolRect(text: "Cat", gradientColors: [.yellow, .white])
                }
            }
            HStack {
                Button() {
                    SoundManager.soundInstance.playSound(sound: .click)
                    viewModel.pet.petType = .bird
                    viewModel.saveData()
                } label: {
                    CoolRect(text: "Bird", gradientColors: [.red, .yellow])
                }
                Button() {
                    SoundManager.soundInstance.playSound(sound: .click)
                    viewModel.pet.petType = .slime
                    viewModel.saveData()
                } label: {
                    CoolRect(text: "Slime", gradientColors: [.green, .cyan])
                }
                Button() {
                    SoundManager.soundInstance.playSound(sound: .click)
                    viewModel.pet.petType = .fish
                    viewModel.saveData()
                } label: {
                    CoolRect(text: "Fish", gradientColors: [.blue, .black])
                }
            }
        }
    }
}

struct DeveloperToolsView_Preview: PreviewProvider {
    static var previews: some View {
        DeveloperToolsView()
    }
}
