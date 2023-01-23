import SwiftUI

struct StatView: View {
    
    @State var viewModel = PetViewModel()
    @State var frame: CGSize = .zero
    
    var body: some View {
        List {
            VStack(spacing: 20) {
                waterBar
                foodBar
                loveBar
                hygieneBar
            }
            .padding()
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
                    .frame(width: geometry.size.width * viewModel.pet.thirst)
                Text("Thirst: \(Double(viewModel.pet.thirst).formatted(.percent))")
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
                    .frame(width: geometry.size.width * viewModel.pet.hunger)
                Text("Hunger: \(Double(viewModel.pet.hunger).formatted(.percent))")
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
                    .frame(width: geometry.size.width * viewModel.pet.love)
                Text("Love: \(Double(viewModel.pet.love).formatted(.percent))")
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
                    .frame(width: geometry.size.width * viewModel.pet.hygiene)
                Text("Hygiene: \(Double(viewModel.pet.hygiene).formatted(.percent))")
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
