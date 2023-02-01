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
        VStack {
            Text("Developer Tools")
                .bold()
                .font(.largeTitle)
                .frame(alignment: .top)
            Spacer()
            Button() {
                SoundManager.soundInstance.playSound(sound: .click)
                viewModel.pet.name = "Pikachan"
                viewModel.pet.image = "pikachan"
                viewModel.saveData()
            } label: {
                CoolRect(text: "??", gradientColors: [.cyan, .blue])
            }
            Button() {
                SoundManager.soundInstance.playSound(sound: .click)
                viewModel.store.add(money: 999999)
                viewModel.saveData()
            } label: {
                CoolRect(text: "Add Money", gradientColors: [.green, .yellow])
            }
            Button() {
                SoundManager.soundInstance.playSound(sound: .click)
                viewModel.pet.isAlive = false
                viewModel.saveData()
            } label: {
                CoolRect(text: "Kill Pet", gradientColors: [.gray, .white])
            }
            Spacer()
            Button() {
                SoundManager.soundInstance.playSound(sound: .click)
                presentationMode.wrappedValue.dismiss()
            } label: {
                CoolRect(text: "Back", gradientColors: [.blue, .cyan])
            }
        }
    }
}

struct DeveloperToolsView_Preview: PreviewProvider {
    static var previews: some View {
        DeveloperToolsView()
    }
}
