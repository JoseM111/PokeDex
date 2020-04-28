import UIKit

class PokemonVC: UIViewController {
    
    // MARK: _@IBOutlet
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNamedLabel: UILabel!
    @IBOutlet weak var pokeIDLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokeSearchBar.delegate = self
    }
    
    // MARK: _@Methods
    func fetchSpriteAndUpdateUI(for pokemon: Pokemon) {
        
        PokemonModelController.fechSprite(for: pokemon) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                    case .success(let sprite):
                        self.pokeImageView.image = sprite
                        self.pokeNamedLabel.text = pokemon.name
                        self.pokeIDLabel.text = String(pokemon.id)
                    case .failure(let error):
                        self.presentErrorToUser(localizedError: error)
                }
            }
        }
        
    }
}

extension PokemonVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        
        PokemonModelController.fetchPokemon(searchTerm: searchTerm) { (result) in
            
            DispatchQueue.main.async {
            switch result {
                case .success(let pokemon):
                    self.fetchSpriteAndUpdateUI(for: pokemon)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
            }
            }
        }
    }
}
