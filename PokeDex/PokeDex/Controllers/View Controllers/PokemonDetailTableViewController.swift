//
//  PokemonDetailTableViewController.swift
//  PokeDex
//
//  Created by Maxwell Poffenbarger on 1/22/20.
//  Copyright © 2020 Poff Daddy. All rights reserved.
//

import UIKit

class PokemonDetailTableViewController: UITableViewController {
    
    //MARK: - Properties
    var pokemon: Pokemon?

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let pokemon = self.pokemon else {return 0}
        return pokemon.detailArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokeCell", for: indexPath)
        guard let pokemon = pokemon else {return UITableViewCell()}
        let detail = pokemon.detailArray[indexPath.row]
        cell.textLabel?.text = detail

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        pokemon?.name.capitalizingFirstLetter()
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    guard let header = view as? UITableViewHeaderFooterView else { return }
    header.textLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    header.textLabel?.font = UIFont.boldSystemFont(ofSize: 25)
    header.textLabel?.frame = header.frame
    header.textLabel?.textAlignment = .center
    }
    
    //MARK: - Navigation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.textLabel?.text == "Appears in Games..." {
            performSegue(withIdentifier: "toGamesDetailVC") {
             func prepare(for segue: UIStoryboardSegue, sender: Any) {
                guard let destinationVC = segue.destination as? GamesDetailTableViewController else {return}
                destinationVC.pokemon = self.pokemon
                }
            }
        }
    }
}//End of class
