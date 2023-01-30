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
    
    @State private var confirmAlert = (title: "Are you sure?", message: "Doing this will delete all data and reset the game to when it was first installed...", isShown: false)
    
    var body: some View {
        VStack {
            Text("Developer Tools")
                .bold()
                .font(.largeTitle)
                .frame(alignment: .top)
            Spacer()
            Button() {
                viewModel.pet.name = "Pikachan"
                viewModel.pet.image = "pikachan"
                viewModel.saveData()
            } label: {
                CoolRect(text: "??", gradientColors: [.cyan, .blue])
            }
            Button() {
                viewModel.store.add(money: 999999)
                viewModel.saveData()
            } label: {
                CoolRect(text: "Add Money", gradientColors: [.green, .yellow])
            }
            Button() {
                viewModel.pet.isAlive = false
                viewModel.saveData()
            } label: {
                CoolRect(text: "Kill Pet", gradientColors: [.gray, .white])
            }
//            Button() {
//                confirmAlert.isShown = true
//            } label: {
//                CoolRect(text: "Delete All Data", gradientColors: [.red, .white])
//            }
            Spacer()
            Button() {
                presentationMode.wrappedValue.dismiss()
            } label: {
                CoolRect(text: "Back", gradientColors: [.blue, .cyan])
            }
        }
        .alert(confirmAlert.title, isPresented: $confirmAlert.isShown) {
            Button("Yes") {
                viewModel.userDefaultPet.deleteData()
                confirmAlert.isShown = false
            }
            Button("No") {
                confirmAlert.isShown = false
            }
        } message: {
            Text(confirmAlert.message)
        }
    }
}

struct DeveloperToolsView_Preview: PreviewProvider {
    static var previews: some View {
        DeveloperToolsView()
    }
}
