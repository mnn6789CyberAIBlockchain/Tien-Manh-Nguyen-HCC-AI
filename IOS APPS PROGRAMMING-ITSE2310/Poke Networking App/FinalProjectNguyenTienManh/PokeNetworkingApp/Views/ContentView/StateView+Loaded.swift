import SwiftUI

struct StateViewLoaded: View {
    @ObservedObject private var vm: ContentViewModel
    
    init(vm: ContentViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        ScrollView {
            if let pokemon = vm.pokemon {
                PokemonView(
                    viewModel: .init(
                        networkManager: vm.networkManager,
                        pokemon: pokemon
                    )
                )
            } else {
                Text("Something went wrong")
            }
        }
    }
}

#Preview {
    StateViewLoaded(vm: ContentViewModel())
}
