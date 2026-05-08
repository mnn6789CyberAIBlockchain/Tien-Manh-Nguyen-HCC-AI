import Foundation

class NetworkManager {
    let baseUrl = "https://pokeapi.co/api/v2/pokemon/"
    
    func getPokemonData(for pokemonNumber: Int) async throws -> Pokemon {
        let fullURLString = "\(baseUrl)\(pokemonNumber)"

        guard let url = URL(string: fullURLString)
        else { throw NetworkError.BadUrl }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
        
        return pokemon
    }
    
    func getPokemonImage(from urlString: String) async throws -> Data? {
        guard let url = URL(string: urlString)
        else { throw NetworkError.BadUrl }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
