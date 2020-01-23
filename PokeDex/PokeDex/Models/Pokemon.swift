//
//  Pokemon.swift
//  PokeDex
//
//  Created by Maxwell Poffenbarger on 1/21/20.
//  Copyright © 2020 Poff Daddy. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    
    let name: String
    let id: Int
    let sprites: Sprites
    let typeArray: [Types]
    var detailArray: [String] {
        var placeholderArray: [String] = []
        placeholderArray.append("ID: \(id)")
        for type in typeArray {
            if type.slot == 1 {
                placeholderArray.append("Type: \(type.type.name.capitalizingFirstLetter())")
            }
        }
        return placeholderArray
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case sprites
        case typeArray = "types"
    }//End of enum
    
    struct Sprites: Decodable {
        
        let classic: URL
        let shinySprite: URL
        
        enum CodingKeys: String, CodingKey {
            case classic = "front_default"
            case shinySprite = "front_shiny"
        }//End of enum
        
    }//End of struct
    
    struct Types: Decodable {
        
        let slot: Int
        let type: pokemonType
    }//End of struct
    
    struct pokemonType: Decodable {
        let name: String
    }//End of struct
    
}//End of struct
