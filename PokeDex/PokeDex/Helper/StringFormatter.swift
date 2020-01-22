//
//  StringExtension.swift
//  PokeDex
//
//  Created by Maxwell Poffenbarger on 1/21/20.
//  Copyright © 2020 Poff Daddy. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}//End of extension
