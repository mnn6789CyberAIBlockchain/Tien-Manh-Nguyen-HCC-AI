import Combine

class ContentViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var state: ContentView.ViewState = .start
    @Published var pokemon: Pokemon? = Pokemon.sample
    
    private(set) var networkManager = NetworkManager()
    
    func updateState() {
        Task {
            state = .loading
            
            do {
                let pokemonNumber = Int(text) ?? 0
                
                pokemon = try await networkManager.getPokemonData(
                    for: pokemonNumber
                )
                
                state = .loaded
                
            } catch {
                print(error)
                state = .error
            }
        }
    }
}
