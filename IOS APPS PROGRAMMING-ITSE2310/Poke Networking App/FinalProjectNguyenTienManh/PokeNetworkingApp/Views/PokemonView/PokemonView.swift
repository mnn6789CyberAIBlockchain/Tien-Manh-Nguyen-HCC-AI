import Combine
import SwiftUI

struct PokemonView: View {
    @ObservedObject private var viewModel: PokemonViewModel
    let pokemon: Pokemon
    
    init(viewModel: PokemonViewModel) {
        self.viewModel = viewModel
        pokemon = viewModel.pokemon
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                if let image = viewModel.pokemonImage {
                    image
                        .resizable()
                        .scaledToFit()
                } else {
                    ProgressView()
                }
            }
            .frame(width: 150, height: 150)
            
            Text(pokemon.name.capitalized)
                .font(.title2)
                .bold()
            
            AbilityView(pokemon: pokemon)
            MoveView(pokemon: pokemon)
            
            Spacer()
        }
        .task {
            do {
                try await viewModel.loadPokemonImage()
            } catch {
                print(error)
            }
        }
    }
}

extension PokemonView {
    
    struct AbilityView: View {
        let pokemon: Pokemon
        
        var body: some View {
            VStack {
                ForEach(0...3, id: \.self) { index in
                    if index < pokemon.abilities.count {
                        HStack {
                            Text("\(pokemon.abilities[index].ability.name)")
                            Spacer()
                        }
                        .foregroundStyle(.white)
                        .padding(10)
                        .background {
                            RoundedRectangle(
                                cornerSize: .init(width: 15, height: 15)
                            )
                            .foregroundStyle(.orange.opacity(0.6))
                        }
                    }
                }
            }
            .padding()
            .background {
                RoundedRectangle(
                    cornerSize: .init(width: 30, height: 30)
                )
                .foregroundStyle(.orange.opacity(0.5))
            }
            .padding()
        }
    }
}

extension PokemonView {
    
    struct MoveView: View {
        let pokemon: Pokemon
        
        var body: some View {
            VStack {
                ForEach(0...3, id: \.self) { index in
                    if index < pokemon.moves.count {
                        HStack {
                            Text("\(pokemon.moves[index].move.name)")
                            Spacer()
                        }
                        .foregroundStyle(.white)
                        .padding()
                        .background {
                            RoundedRectangle(
                                cornerSize: .init(width: 15, height: 15)
                            )
                            .foregroundStyle(.green.opacity(0.6))
                        }
                    }
                }
            }
            .padding()
            .background {
                RoundedRectangle(
                    cornerSize: .init(width: 30, height: 30)
                )
                .foregroundStyle(.green.opacity(0.5))
            }
            .padding()
        }
    }
}

#Preview {
    PokemonView(
        viewModel: PokemonViewModel(
            networkManager: NetworkManager(),
            pokemon: Pokemon.sample
        )
    )
}
