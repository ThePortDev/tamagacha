//
//  DeveloperToolsView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/19/23.
//

import SwiftUI

struct DeveloperToolsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text("DevTools")
            Button("Back") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
