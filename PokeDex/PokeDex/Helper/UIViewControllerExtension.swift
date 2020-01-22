//
//  UIViewControllerExtension.swift
//  PokeDex
//
//  Created by Maxwell Poffenbarger on 1/21/20.
//  Copyright © 2020 Poff Daddy. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentErrorToUser(localizedError: LocalizedError) {
        let alertController = UIAlertController(title: "Error", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true)
    }
    
    func presentNoPokemonError() {
        let alertController = UIAlertController(title: "Who's that Pokemon?", message: "Sorry, that Pokemon does not exist...yet", preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true)
    }
}//End of extension
