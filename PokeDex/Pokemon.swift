//
//  Pokemon.swift
//  PokeDex
//
//  Created by Rael Kenny on 4/30/17.
//  Copyright © 2017 Rael Kenny. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexID: Int!
    
    private var _description: String!
    private var _type: String!
    private var _defense:String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt:String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLevel: String!
    
    private var _pokemonURL: String!
    
    //getters    
    var name:String {
        return _name
    }
    
    var pokedexID:Int {
        return _pokedexID
    }
    
    var nextEvolutionTxt:String{
        
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt = ""
        }
        return _nextEvolutionTxt
    }
    
    var attack:String{
        
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var weight:String{
        
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var height:String{
        
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var defense:String{
        
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var type:String{
        
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var description:String{
        
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var nextEvolutionName:String{
        
        if _nextEvolutionName == nil {
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    var nextEvolutionId:String{
        
        if _nextEvolutionId == nil {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel:String{
        
        if _nextEvolutionLevel == nil {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    
    
    
    //initializer
    init(name: String, pokedexID: Int) {
        self._name = name
        self._pokedexID = pokedexID
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexID)/"
        
    }
    
    //NETWORK REQUEST
    func downloadPokemonDetails(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            
//            print(response.result.value!)
            
            if let dict = response.result.value as? Dictionary<String, Any>{
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String{
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int{
                    self._defense = "\(defense)"
                }
                
                print(self._weight)
                print(self._height)
                print(self._attack)
                print(self._defense)
                
                if let types = dict["types"] as? [Dictionary<String, String>], types.count > 0{
                    
                    if let name = types[0]["name"]{
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                      
                        for x in 1..<types.count {
                            if let name = types[x]["name"]{
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                
                    print(self._type)
                
                
                } else {
                    self._type = ""
                }
                
                if let desArr = dict["descriptions"] as? [Dictionary<String, String>] , desArr.count > 0{
                    
                    if let url = desArr[0]["resource_uri"] {
                    
                        let descURL = "\(URL_BASE)\(url)"
                        
                        Alamofire.request(descURL).responseJSON(completionHandler: { (response) in
                            
                            if let descDict = response.result.value as? Dictionary<String, Any> {
                                if let description = descDict["description"] as? String{
                                    
                                    print(description)
                                }
                            }
                            
                            completed()
                        })
                    }
                    
                }
                
                if let evolutions = dict["evoluations"] as? [Dictionary<String, Any>] , evolutions.count>0 {
                    
                    if let nextEvo = evolutions[0]["to"] as? String{
                        
                        if nextEvo.range(of: "mega") == nil {
                            self._nextEvolutionName = nextEvo
                            
                            if let uri = evolutions[0]["resource_uri"] as? String{
                                
                                let newStr = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newStr.replacingOccurrences(of: "/", with: "")
                                
                                self._nextEvolutionId = nextEvoId
                                
                                if let lvlExist = evolutions[0]["level"]{
                                    if let lvl = lvlExist as? Int{
                                     
                                        self._nextEvolutionLevel = "\(lvl)"
                                    }
                                }
                            }
                        }
                    }
                    
                    print(self.nextEvolutionName)
                    print(self.nextEvolutionId)
                    print(self.nextEvolutionLevel)
                }
            }
         
            completed()
        }
        
    }
    

    
    
}
