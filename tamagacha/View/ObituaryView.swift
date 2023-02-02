//
//  ObituaryView.swift
//  tamagacha
//
//  Created by Hafa Bonati on 2/2/23.
//

import SwiftUI

struct ObituaryView: View {
    
    @EnvironmentObject var viewModel: PetViewModel
    
    @State var petLT = ""
    
    var body: some View {
        VStack {
            obTitle
            Spacer(minLength: 20)
            lifeStat
            Spacer(minLength: 50)
            petDescription
            submitButton
            Spacer(minLength: 50)
        }
    }
    
    var obTitle: some View {
        Text("An Ode To Your Dead Pet:")
            .font(.custom("HangTheDJ", size: 25))
    }
    
    var lifeStat: some View {
        VStack {
            Text("""

* Pet Life Stats *

Name: \(viewModel.pet.name)
Age: \(viewModel.pet.age / 86400)

""")
        }
        .font(.custom("HangTheDJ", size: 30))
        .multilineTextAlignment(.leading)
        .frame(width: 350)
        .background(
            Rectangle()
                .fill(AngularGradient(colors: [.white, .black], center: .topLeading))
                .shadow(
                    color: .black.opacity(0.5),
                    radius: 10,
                    x:0.0, y:10))
    }
    
    var petDescription: some View {
        ScrollView {
            VStack {
                Image(viewModel.pet.image)
                    .resizable()
                    .frame(width: 200, height: 200)
                TextField("Write about your pet here", text: $petLT, axis: .vertical)
                    .multilineTextAlignment(.center)
                    .font(.custom("HangTheDJ", size: 20))
                    .padding()
                    .frame(width: 350)
                
            }
            .background(
                Rectangle()
                    .fill(AngularGradient(colors: [.white, .black], center: .topLeading))
                    .shadow(
                        color: .black.opacity(0.5),
                        radius: 10,
                        x:0.0, y:10))
            
            
        }
    }
    
    @State var goGumballBool = false
    
    var submitButton: some View {
        Button {
            viewModel.pet.description = petLT
            viewModel.pet.deadPets.append(viewModel.pet)
            viewModel.saveData()
            goGumballBool = true
        } label: {
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: 100, height: 100))
                    .fill(AngularGradient(colors: [.blue, .white], center: .topLeading))
                    .frame(width: 280, height: 45)
                    .shadow(
                        color: .black.opacity(0.5),
                        radius: 10,
                        x:0.0, y:10
                    )
                Text("Submit Ode?")
                    .font(.custom("HangTheDJ", size: 35))
                    .colorInvert()
                    .foregroundColor(.black)
                    .bold()
                    .italic()
            }
            .navigate(to: GumballMachineView(), when: $goGumballBool)
        }
    }
    
    struct ObituaryView_Previews: PreviewProvider {
        static var previews: some View {
            ObituaryView()
                .environmentObject(PetViewModel())
        }
    }
}