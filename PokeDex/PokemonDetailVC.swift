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
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonNameLbl.text = pokemonFromCell.name.capitalized
        
        let img = UIImage(named: "\(pokemonFromCell.pokedexID)")
        mainImage.image = img
        currentEvoImage.image = img
        pokedexLbl.text = "\(pokemonFromCell.pokedexID)"
        
        pokemonFromCell.downloadPokemonDetails {
            //whatever we write will only be called after the network call is complete!
            self.updateUI()
        }
    }
    
    func updateUI(){
        attackLbl.text = pokemonFromCell.attack
        defenseLbl.text = pokemonFromCell.defense
        heightLbl.text = pokemonFromCell.height
        weightLbl.text = pokemonFromCell.weight
        typeLbl.text = pokemonFromCell.type
        descriptionLbl.text = pokemonFromCell.description
        
        if pokemonFromCell.nextEvolutionId == "" {
            evoLbl.text = "No Evolution"
            nextEvoImage.isHidden = true
        } else {
            nextEvoImage.isHidden = false
            nextEvoImage.image = UIImage(named: pokemonFromCell.nextEvolutionId)
            let str = "Next Evolution: \(pokemonFromCell.nextEvolutionName) - LVL \(pokemonFromCell.nextEvolutionLevel)"
            evoLbl.text = str
        }
    }


    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }

}
