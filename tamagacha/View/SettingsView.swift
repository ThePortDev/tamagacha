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
            Button("Back") {
                presentationMode.wrappedValue.dismiss()
            }
            
            TextField("Code", text: $enterCode)
                .multilineTextAlignment(.center)
                .autocorrectionDisabled()
                .onSubmit {
                    if enterCode.lowercased() == devCode {
                        navigateToDevTools = true
                    }
                }
            
        }
        .navigate(to: DeveloperToolsView(), when: $navigateToDevTools)

    }
    
}
