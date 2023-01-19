//
//  SettingsView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/19/23.
//

import SwiftUI

struct SettingsView: View {
    @State var enterCode = ""
    @State var navigateToDevTools = false
    var devCode = "cheesepuffs"
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
                .padding(15)
            
                Spacer()
            HStack {
                Text("UI Color:")
                    .font(.headline)
                Image(systemName: "paintpalette")
            }
            
//            HStack {
//                Text("Sound")
//                Slider(
//            }
            
            TextField("Code", text: $enterCode)
                .multilineTextAlignment(.center)
                .autocorrectionDisabled()
                .onSubmit {
                    if enterCode.lowercased() == devCode {
                        navigateToDevTools = true
                    }
                }
                .padding(5)
            
            Spacer()
            
            Button("Back") {
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigate(to: DeveloperToolsView(), when: $navigateToDevTools)

    }
}

struct SettingsView_Preview: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
