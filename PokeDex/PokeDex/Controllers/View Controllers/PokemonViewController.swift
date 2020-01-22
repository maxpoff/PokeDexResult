//
//  PokemonViewController.swift
//  PokeDex
//
//  Created by Maxwell Poffenbarger on 1/21/20.
//  Copyright © 2020 Poff Daddy. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var spriteImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLAbel: UILabel!
    @IBOutlet weak var toggleIsShinyButton: UIButton!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var populateType: UILabel!
    @IBOutlet weak var populateID: UILabel!
    
    var pokemon: Pokemon?
    var isShiny = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeSearchBar.delegate = self
    }
    
    //MARK: Actions
    @IBAction func shinyButtonTapped(_ sender: UIButton) {
        guard let pokemon = pokemon else {return}
        switch self.isShiny {
        case true:
            fetchSpriteAndUpdateViews(for: pokemon)
        default:
            fetchShinySpriteAndUpdateViews(for: pokemon)
        }
        isShiny.toggle()
    }//End of action
    
    //MARK: Private Methods
    
    private func fetchSpriteAndUpdateViews(for pokemon: Pokemon) {
        
        PokemonController.fetchSprite(for: pokemon) { (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let sprite):
                    self.nameLabel.text = pokemon.name.capitalizingFirstLetter()
                    self.idLAbel.text = "\(pokemon.id)"
                    self.spriteImageView.image = sprite
                    self.populateType.text = "Type:"
                    self.populateID.text = "ID:"
                    
                    for type in pokemon.typeArray {
                        if type.slot == 1 {
                            self.typeLabel.text = type.type.name.capitalizingFirstLetter()
                            self.backgroundChange()
                        }
                    }
                    
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    func fetchShinySpriteAndUpdateViews(for pokemon: Pokemon) {
        
        PokemonController.fetchShinySprite(for: pokemon) { (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let shinySprite):
                    self.spriteImageView.image = shinySprite
                    
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    func backgroundChange() {
        guard let textLabelText = typeLabel.text else {return}
        let background = "\(textLabelText)Background"
        backgroundImage.image = UIImage(named: String(background))
    }
    
}//End of class

//MARK: - UISearchBar Delegate

extension PokemonViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {return}
        
        PokemonController.fetchPokemon(for: searchTerm) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    self.fetchSpriteAndUpdateViews(for: pokemon)
                    self.pokemon = pokemon
                    searchBar.text = ""
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}//End of extension
