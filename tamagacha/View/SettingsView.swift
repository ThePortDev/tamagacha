//
//  SettingsView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/19/23.
//

import SwiftUI

struct SettingsView: View {

    @State private var volume: Double = 0
    @State private var hasChanged: Bool = false
    @State var enterCode = ""
    @State var navigateToDevTools = false
    
    private let devCode = "cheesepuffs"
    private let range: ClosedRange<Double> = 0...100
    private let step: Double = 1
    
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
            .padding(15)
            
            VStack {
                Text("Volume | \(Int(volume))%")
                HStack {
                    decreaseButton
                        .foregroundColor(.black)
                    Slider(value: $volume, in: range, step: step) { hasChanged in
                        self.hasChanged = hasChanged
                    }
                    increaseButton
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 25)
            
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

private extension SettingsView {
    
    func increase() {
        guard volume < range.upperBound else { return }
        volume += step
    }
    
    func decrease() {
        guard volume > range.lowerBound else { return }
        volume -= step
    }
}

private extension SettingsView {
    
    var increaseButton: some View {
        Button {
                increase()
        } label: {
            Image(systemName: "plus")
        }
        .opacity(hasChanged ? 0.5 : 1)
        .disabled(hasChanged)
    }
    
    var decreaseButton: some View {
        Button {
                decrease()
        } label: {
            Image(systemName: "minus")
        }
        .opacity(hasChanged ? 0.5 : 1)
        .disabled(hasChanged)
    }
}

struct SettingsView_Preview: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
