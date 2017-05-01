//
//  ViewController.swift
//  PokeDex
//
//  Created by Rael Kenny on 4/30/17.
//  Copyright © 2017 Rael Kenny. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemonArray = [Pokemon]()
    var filteredPokemonArray = [Pokemon]() //for searchbar = filtered array
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        parsePokemonCSV()
        
    }

    func parsePokemonCSV(){
        
        //created a path to the pokemon.csv file
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfURL: path!) //use the parser to pull out each row
            let rows = csv.rows
            print(rows)
            
            //go through each row for the name and ID
            for row in rows {
                let pokeId = Int(row["id"]!)!
                let pokeName = row["identifier"]!
                
                //poke Object + add to pokemon Array
                let poke = Pokemon(name: pokeName, pokedexID: pokeId)
                pokemonArray.append(poke)
                
            }
        }
        catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
                    
            let poke: Pokemon!
            
            if inSearchMode{
                poke = filteredPokemonArray[indexPath.row]
                cell.configureCell(poke)
            }
            else
            {
                poke = pokemonArray[indexPath.row]
                cell.configureCell(poke)
            }
            
            return cell
            
        } else {
            
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: Pokemon!
        
        if inSearchMode {
            poke = filteredPokemonArray[indexPath.row]
        }
        else
        {
            poke = pokemonArray[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode {
            return filteredPokemonArray.count
        }
        
        return pokemonArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
        }
        else
        {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            filteredPokemonArray = pokemonArray.filter({$0.name.range(of: lower) != nil})
            
            collection.reloadData() //reload collectionView
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC"{
            if let detailVC = segue.destination as? PokemonDetailVC{
                if let poke = sender as? Pokemon {
                    detailVC.pokemonFromCell = poke
                }
            }
        }
    
    }
}
