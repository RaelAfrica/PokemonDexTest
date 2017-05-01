//
//  PokeCell.swift
//  PokeDex
//
//  Created by Rael Kenny on 4/30/17.
//  Copyright © 2017 Rael Kenny. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemonVar: Pokemon!
    
    func configureCell (pokemonPara:Pokemon){
        
        self.pokemonVar = pokemonPara
        
        nameLbl.text = self.pokemonVar.name.capitalized
        thumbImage.image = UIImage(named: "\(self.pokemonVar.pokedexID)")
    }
}
