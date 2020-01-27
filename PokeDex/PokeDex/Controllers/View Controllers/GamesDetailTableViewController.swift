//
//  GamesDetailTableViewController.swift
//  PokeDex
//
//  Created by Maxwell Poffenbarger on 1/23/20.
//  Copyright © 2020 Poff Daddy. All rights reserved.
//

import UIKit

class GamesDetailTableViewController: UITableViewController {
    
    //MARK: - Properties
    var pokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let pokemon = pokemon else {return 0}
        return pokemon.gameIndicesArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        

        return cell
    }
}
