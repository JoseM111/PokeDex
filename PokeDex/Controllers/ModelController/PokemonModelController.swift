import Foundation
import UIKit.UIImage

class PokemonModelController {
    
    // MARK: @Magic-Strings
    static let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon")
    
    // MARK: _@Static shared function
    static func fetchPokemon(searchTerm: String,
                             completion: @escaping (Result<Pokemon, PokemonError>) -> Void) {
        
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        // appendingPathComponent:--? Appends the search term at the end of the url
        // EXAMPLE: "https://foo.co/api/v2/foo/searchTerm"
        let finalURL = baseURL.appendingPathComponent(searchTerm)
        
        /**©-----------------------------©*/
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
                   
                   if let error = error {
                       return completion(.failure(.thrownError(error)))
                   }
                   
                   guard let data = data else { return completion(.failure(.noData)) }
                   
                   do {
                       let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                       return completion(.success(pokemon))
                   } catch let decodingError {
                       return completion(.failure(.thrownError(decodingError)))
                   }
               }.resume()
        /**©-----------------------------©*/
    }
    
    /**©------------------------------------------------------------------------------©*/
    static func fechSprite(for pokemon: Pokemon,
                           completion: @escaping (Result<UIImage, PokemonError>) -> Void) {
        
        let spriteURL = pokemon.sprites.classicSprite
        /**©-----------------------------©*/
        URLSession.shared.dataTask(with: spriteURL) { (data, _, error) in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            
            return completion(.success(image))
        }.resume()
        /**©-----------------------------©*/
    }
    /**©------------------------------------------------------------------------------©*/
}// END OF CLASS
