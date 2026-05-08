import SwiftUI

struct Pokemon: Codable {
    let name: String
    let height: Int
    let abilities: [AbilityWrapper]
    let moves: [MoveWrapper]
    let sprites: Sprites
    
    func getImage(from networkManager: NetworkManager) async throws -> Image? {
        let imageURLString = sprites.front_default ?? sprites.back_default ?? ""
        
        guard let imageData = try await networkManager.getPokemonImage(
            from: imageURLString
        )
        else { return nil }
        
        guard let uiImage = UIImage(data: imageData)
        else { return nil }
        
        return Image(uiImage: uiImage)
    }
}

struct Sprites: Codable {
    let front_default: String?
    let back_default: String?
}

struct AbilityWrapper: Codable {
    let ability: Ability
    let is_hidden: Bool
    let slot: Int
}

struct Ability: Codable {
    let name: String
}

struct MoveWrapper: Codable {
    let move: Move
}

struct Move: Codable {
    let name: String
}
