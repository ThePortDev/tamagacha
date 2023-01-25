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
            Button("Reset Game") {
                confirmAlert.isShown = true
            }
            Spacer()
            Button("Back") {
                presentationMode.wrappedValue.dismiss()
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
