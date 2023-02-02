//
//  SettingsView.swift
//  tamagacha
//
//  Created by Porter Dover on 1/19/23.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var viewModel: PetViewModel
    
    @StateObject var settingsVM = SettingsVM()
    
    @State private var hasChanged: Bool = false
    @State var enterCode = ""
    @State var navigateToDevTools = false
    
    private let devGunCode = "GunsRToysRight?"
    private let devCode = "code"
    private let range: ClosedRange<Double> = 0.00...1.00
    private let step: Double = 0.01
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack {
            
            settingsTitle
            
            Spacer()
            
//            UIColorPicker
            
            volumeSlider
            
            soundFXSlider
            
            devTools
                .padding(15)
            
            Spacer()
            
            backBTN
            
        }
        .background(Values.primary)
        
        .navigate(to: DeveloperToolsView().environmentObject(viewModel), when: $navigateToDevTools)
        
    }
    
    var settingsTitle: some View {
        Text("Settings")
            .font(.largeTitle)
            .padding(15)
    }
    
//    var UIColorPicker: some View {
//        
//        HStack {
//            Text("UI Color:")
//                .font(.headline)
//                .foregroundColor(Values.buttonsColor)
//            
//            Button(action: buttonPressed) {
//                Image(systemName: "paintpalette")
//                    .foregroundColor(Values.buttonsColor)
//            }
//        }
//        .padding(15)
//    }
    
    var volumeSlider: some View {
        
        VStack {
            Text("Volume | \(Int(settingsVM.volume * 100))%")
                .foregroundColor(Values.secondary)
            
            HStack {
                decreaseButton
                    .foregroundColor(Values.secondary)
                
                Slider(value: $settingsVM.volume)
                    .tint(Values.secondary)
                    .onChange(of: self.settingsVM.volume) { value in
                        SoundManager.soundInstance.playSound(sound: .swoosh)
                        SoundManager.soundInstance.player?.volume = Float(value)
                    }
                
                increaseButton
                    .foregroundColor(Values.secondary)
            }
        }
        .padding(.horizontal, 25)
    }
    
    var soundFXSlider: some View {
        VStack {
            Text("SFX Volume | \(Int(settingsVM.SFXVolume * 100))%")
                .foregroundColor(Values.secondary)
            
            HStack {
                decreaseButton
                    .foregroundColor(Values.secondary)
                
                Slider(value: $settingsVM.SFXVolume)
                    .tint(Values.secondary)
                    .onChange(of: self.settingsVM.SFXVolume) { value in
                        SoundManager.soundInstance.playSound(sound: .swoosh)
                        SoundManager.soundInstance.soundPlayer?.volume = Float(value)
                    }
                
                increaseButton
                    .foregroundColor(Values.secondary)
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
                } else if enterCode == devGunCode {
                    print("That's the code!")
                }
            }
            .padding(5)
    }
    
    var backBTN: some View {
        
        Button("Back") {
            SoundManager.soundInstance.playSound(sound: .click)
            dismiss()
        }
        .foregroundColor(Values.secondary)
        
    }
}


private extension SettingsView {
    
    func buttonPressed() {
        print("Button Has Been Pressed")
    }
}

private extension SettingsView {
    
    func increase() {
        guard settingsVM.volume < range.upperBound else { return }
        settingsVM.volume += step
    }
    
    func decrease() {
        guard settingsVM.volume > range.lowerBound else { return }
        settingsVM.volume -= step
    }
    
    func increaseSFX() {
        guard settingsVM.SFXVolume < range.upperBound else { return }
        settingsVM.SFXVolume += step
    }
    
    func decreaseSFX() {
        guard settingsVM.SFXVolume > range.lowerBound else { return }
        settingsVM.SFXVolume -= step
    }
}

private extension SettingsView {
    
    var increaseButton: some View {
        Button {
            SoundManager.soundInstance.playSound(sound: .click)
            increase()
        } label: {
            Image(systemName: "plus")
        }
        .opacity(hasChanged ? 0.5 : 1)
        .disabled(hasChanged)
    }
    
    var decreaseButton: some View {
        Button {
            SoundManager.soundInstance.playSound(sound: .click)
            decrease()
        } label: {
            Image(systemName: "minus")
        }
        .opacity(hasChanged ? 0.5 : 1)
        .disabled(hasChanged)
    }
    
    var increaseButtonSFX: some View {
        Button {
            SoundManager.soundInstance.playSound(sound: .click)
            increaseSFX()
        } label: {
            Image(systemName: "plus")
        }
        .opacity(hasChanged ? 0.5 : 1)
        .disabled(hasChanged)
    }
    
    var decreaseButtonSFX: some View {
        Button {
            SoundManager.soundInstance.playSound(sound: .click)
            decreaseSFX()
        } label: {
            Image(systemName: "minus")
        }
        .opacity(hasChanged ? 0.5 : 1)
        .disabled(hasChanged)
    }
}

private extension SettingsView {
    enum Values {
        static let primary = SnakeColors.primary
        static let secondary = SnakeColors.secondary
    }
}

enum SnakeColors {
    static let primary = Color("Primary")
    static let secondary = Color("Secondary")
}


struct SettingsView_Preview: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(PetViewModel())
    }
}
