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
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var pokemon: Pokemon?
    var isShiny = false
    var idNumber: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designNextButton()
        designPreviousButton()
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
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard var idNumber = idNumber else {return}
        idNumber += 1
        let idNumberAsString = String(idNumber)
        PokemonController.fetchPokemon(for: idNumberAsString) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    self.fetchSpriteAndUpdateViews(for: pokemon)
                    self.pokemon = pokemon
                case .failure:
                    self.presentNoPokemonError()
                }
            }
        }
    }
    
    @IBAction func previousButtonTapped(_ sender: Any) {
        guard var idNumber = idNumber else {return}
        idNumber -= 1
        let idNumberAsString = String(idNumber)
        PokemonController.fetchPokemon(for: idNumberAsString) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    self.fetchSpriteAndUpdateViews(for: pokemon)
                    self.pokemon = pokemon
                case .failure:
                    self.presentNoPokemonError()
                }
            }
        }
    }
    
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
                    self.idNumber = pokemon.id
                    
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
    
    func designNextButton() {
        nextButton.layer.borderWidth = 2
        nextButton.layer.borderColor = UIColor.black.cgColor
        nextButton.layer.cornerRadius = nextButton.frame.height / 3
        nextButton.backgroundColor = #colorLiteral(red: 0.9457877278, green: 0.4133938849, blue: 0.3941661119, alpha: 1)
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.setTitle("Next Pokemon", for: .normal)
    }
    
    func designPreviousButton() {
        previousButton.layer.borderWidth = 2
        previousButton.layer.borderColor = UIColor.black.cgColor
        previousButton.layer.cornerRadius = previousButton.frame.height / 3
        previousButton.backgroundColor = #colorLiteral(red: 0.9457877278, green: 0.4133938849, blue: 0.3941661119, alpha: 1)
        previousButton.setTitleColor(.black, for: .normal)
        previousButton.setTitle("Previous Pokemon", for: .normal)
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
