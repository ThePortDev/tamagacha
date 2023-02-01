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
            
            devTools
                .padding(15)
            
            Spacer()
            
            backBTN
            
        }
        .background(Values.gameBackgroundColor)
        
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
                .foregroundColor(Values.buttonsColor)
            HStack {
                decreaseButton
                    .foregroundColor(Values.buttonsColor)
                
                Slider(value: $settingsVM.volume)
                    .onChange(of: self.settingsVM.volume) { value in
                        SoundManager.soundInstance.player?.volume = Float(value)
                    }
                
                increaseButton
                    .foregroundColor(Values.buttonsColor)
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
            dismiss()
        }
        .foregroundColor(Values.buttonsColor)
        
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

private extension SettingsView {
    enum Values {
        static let gameBackgroundColor = SnakeColors.gameBackground
        static let buttonsColor = SnakeColors.buttonColors
    }
}

enum SnakeColors {
    static let gameBackground = Color("Background")
    static let buttonColors = Color("PlusMinus")
}


struct SettingsView_Preview: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(PetViewModel())
    }
}
