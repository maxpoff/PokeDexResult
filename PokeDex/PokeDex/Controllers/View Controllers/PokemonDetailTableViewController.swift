//
//  PokemonDetailTableViewController.swift
//  PokeDex
//
//  Created by Maxwell Poffenbarger on 1/22/20.
//  Copyright © 2020 Poff Daddy. All rights reserved.
//

import UIKit

class PokemonDetailTableViewController: UITableViewController {
    
    var pokemon: Pokemon? {
        didSet {
            //print(pokemon?.name)
        }
    }

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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}//End of class
