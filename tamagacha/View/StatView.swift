import SwiftUI

struct StatView: View {
    
//    @StateObject private var viewModel = PetViewModel()
    @EnvironmentObject var viewModel: PetViewModel
    private let timer = Timer.publish(every: 15, on: .main, in: .common)
    
    var body: some View {
            VStack(spacing: 20) {
                waterBar
                foodBar
                loveBar
                hygieneBar
            }
            .frame(height: 150)
            .padding()
            .onReceive(timer) { _ in
                viewModel.saveData()
            }
    }
    
    var waterBar: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.gray)
                    .frame(width: geometry.size.width)
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.blue)
                    .frame(width: geometry.size.width * (viewModel.pet.thirst / 100))
                Text("Thirst: \(Int(viewModel.pet.thirst))")
                    .padding(.leading, 10)
                    .padding(5)
            }
        }
    }
    
    var foodBar: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.gray)
                    .frame(width: geometry.size.width)
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.yellow)
                    .frame(width: geometry.size.width * (viewModel.pet.hunger / 100))
                Text("Hunger: \(Int(viewModel.pet.hunger))")
                    .padding(.leading, 10)
                    .padding(5)
            }
        }
    }
    
    var loveBar: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.gray)
                    .frame(width: geometry.size.width)
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.red)
                    .frame(width: geometry.size.width * (viewModel.pet.love / 100))
                Text("Love: \(Int(viewModel.pet.love))")
                    .padding(.leading, 10)
                    .padding(5)
            }
        }
    }
    
    var hygieneBar: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.gray)
                    .frame(width: geometry.size.width)
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.green)
                    .frame(width: geometry.size.width * (viewModel.pet.hygiene / 100))
                Text("Hygiene: \(Int(viewModel.pet.hygiene))")
                    .padding(.leading, 10)
                    .padding(5)
            }
        }
    }
}

struct StatView_Previews: PreviewProvider {
    static var previews: some View {
        StatView()
    }
}
