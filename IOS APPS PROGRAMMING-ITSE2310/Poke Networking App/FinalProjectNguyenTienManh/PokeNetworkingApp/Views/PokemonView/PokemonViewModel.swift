import Combine
import SwiftUI

class PokemonViewModel: ObservableObject {
    let networkManager: NetworkManager
    let pokemon: Pokemon
    
    @Published private(set) var pokemonImage: Image? = nil
    
    init(networkManager: NetworkManager, pokemon: Pokemon) {
        self.networkManager = networkManager
        self.pokemon = pokemon
    }
    
    func loadPokemonImage() async throws {
        pokemonImage = try await pokemon.getImage(from: networkManager)
    }
}
