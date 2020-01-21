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
    let baseXP: Int
    let sprites: Sprites
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case baseXP = "base_experience"
        case sprites
    }
    
    struct Sprites: Decodable {
        
        let classic: URL
        
        enum CodingKeys: String, CodingKey {
            case classic = "front_default"
        }//End of enum
        
    }//End of struct
    
}//End of class
