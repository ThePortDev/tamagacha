import SwiftUI

struct StatBar: View {
    
    var name: String
    var value: CGFloat
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.gray)
                    .frame(width: geometry.size.width)
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(color)
                    .frame(width: geometry.size.width * (value / 100))
                Text("\(name): \(Int(value))")
                    .padding(.leading, 10)
                    .padding(5)
            }
        }
    }
}


struct StatView: View {
    
//    @StateObject private var viewModel = PetViewModel()
    @EnvironmentObject var viewModel: PetViewModel
    private let timer = Timer.publish(every: 15, on: .main, in: .common)
    
    var body: some View {
            VStack(spacing: 20) {

                StatBar(name: "Thirst", value: viewModel.pet.thirst, color: .blue)
                StatBar(name: "Hunger", value: viewModel.pet.hunger, color: .yellow)
                StatBar(name: "Love", value: viewModel.pet.love, color: .red)
                StatBar(name: "Hygiene", value: viewModel.pet.hygiene, color: .green)
            }
            .frame(height: 150)
            .padding()
            .onReceive(timer) { _ in
                viewModel.saveData()
            }
    }
    

}

struct StatView_Previews: PreviewProvider {
    static var previews: some View {
        StatView()
    }
}
