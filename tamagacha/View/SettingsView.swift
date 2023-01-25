//
//  SettingsView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/19/23.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var viewModel: PetViewModel
    
    @State private var volume: Double = 0.50
    @State private var hasChanged: Bool = false
    @State var enterCode = ""
    @State var navigateToDevTools = false
    
    private let devCode = "cheesepuffs"
    private let range: ClosedRange<Double> = 0.00...1.00
    private let step: Double = 0.01
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        VStack {
            
            settingsTitle
            
            Spacer()
            
            UIColorPicker
            
            volumeSlider
            
            devTools
                .padding(15)
            
            Spacer()
            
            backBTN
        }
        
        .navigate(to: DeveloperToolsView().environmentObject(viewModel), when: $navigateToDevTools)
        
    }
    
    var settingsTitle: some View {
        Text("Settings")
            .font(.largeTitle)
            .padding(15)
    }
    
    var UIColorPicker: some View {
        
        HStack {
            Text("UI Color:")
                .font(.headline)
            
            Button(action: buttonPressed) {
                Image(systemName: "paintpalette")
                    .foregroundColor(.black)
            }
        }
        .padding(15)
    }
    
    var volumeSlider: some View {
        
        VStack {
            Text("Volume | \(Int(volume * 100))%")
            HStack {
                decreaseButton
                    .foregroundColor(.black)
                
                Slider(value: $volume)
                    .onChange(of: self.volume) { value in
                        SoundManager.soundInstance.player?.volume = Float(value)
                    }
                
                increaseButton
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal, 25)
    }
    
    var devTools: some View {
        
        TextField("Code", text: $enterCode)
            .multilineTextAlignment(.center)
            .autocorrectionDisabled()
            .onSubmit {
                if enterCode.lowercased() == devCode {
                    navigateToDevTools = true
                }
            }
            .padding(5)
    }
    
    var backBTN: some View {
        
        Button("Back") {
            presentationMode.wrappedValue.dismiss()
        }
        
    }
}

private extension SettingsView {
    
    func buttonPressed() {
        print("Button Has Been Pressed")
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
