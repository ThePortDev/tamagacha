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
        .background(ThemeColors.primary)
        .navigate(to: DeveloperToolsView().environmentObject(viewModel), when: $navigateToDevTools)
        
    }
    
    var settingsTitle: some View {
        Text("Settings")
            .font(.custom("Yoster Island", size: 40))
            .padding(.top, 15)
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
            Text("Music Volume \(Int(settingsVM.volume * 100))%")
                .font(.custom("Yoster Island", size: 18))
                .foregroundColor(ThemeColors.accent)
            
            HStack {
                decreaseButton
                    .foregroundColor(ThemeColors.accent)
                
                Slider(value: $settingsVM.volume)
                    .tint(ThemeColors.accent)
                    .onChange(of: self.settingsVM.volume) { value in
                        SoundManager.soundInstance.playSound(sound: .swoosh)
                        SoundManager.soundInstance.player?.volume = Float(value)
                    }
                
                increaseButton
                    .foregroundColor(ThemeColors.accent)
            }
        }
        .padding(.horizontal, 25)
    }
    
    var soundFXSlider: some View {
        VStack {
            Text("SFX Volume \(Int(settingsVM.SFXVolume * 100))%")
                .font(.custom("Yoster Island", size: 18))
                .foregroundColor(ThemeColors.accent)
            
            HStack {
                decreaseButtonSFX
                    .foregroundColor(ThemeColors.accent)
                
                Slider(value: $settingsVM.SFXVolume)
                    .tint(ThemeColors.accent)
                    .onChange(of: self.settingsVM.SFXVolume) { value in
                        SoundManager.soundInstance.playSound(sound: .swoosh)
                        SoundManager.soundInstance.soundPlayer?.volume = Float(value)
                    }
                
                increaseButtonSFX
                    .foregroundColor(ThemeColors.accent)
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
            .onChange(of: enterCode, perform: { _ in
                SoundManager.soundInstance.playSound(sound: .typing)
            })
            .padding(5)
    }
    
    var backBTN: some View {
        
        Button {
            SoundManager.soundInstance.playSound(sound: .click)
            dismiss()
        } label: {
            Text("Back")
                .font(.custom("Yoster Island", size: 26))
                .foregroundColor(ThemeColors.primary)
                .bold()
                .padding()
                .background(
                    RoundedRectangle(cornerSize: CGSize(width: 100, height: 100))
                        .foregroundColor(ThemeColors.accent)
                        .shadow(
                            color: .black.opacity(0.5),
                            radius: 10,
                            x:0.0, y:10)
                )
        }
        .foregroundColor(ThemeColors.accent)
        
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
