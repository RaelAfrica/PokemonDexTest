//
//  Pokemon.swift
//  PokeDex
//
//  Created by Rael Kenny on 4/30/17.
//  Copyright © 2017 Rael Kenny. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokedexID: Int!
    
    //getters    
    var name:String {
        return _name
    }
    
    var pokedexID:Int {
        return _pokedexID
    }
    
    //initializer
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
    }
    

    
    
}
