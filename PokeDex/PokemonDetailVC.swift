//
//  PokemonDetailVC.swift
//  PokeDex
//
//  Created by Rael Kenny on 5/1/17.
//  Copyright © 2017 Rael Kenny. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemonFromCell: Pokemon!
    
    @IBOutlet weak var pokemonNameLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonNameLbl.text = pokemonFromCell.name
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
