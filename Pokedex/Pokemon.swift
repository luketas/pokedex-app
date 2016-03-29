//
//  Pokemon.swift
//  Pokedex
//
//  Created by Lucas Franco on 3/28/16.
//  Copyright © 2016 Lucas Franco. All rights reserved.
//

import Foundation
import Alamofire



class Pokemon {
    private var _name: String!
    private var _pokedexid: Int!
    private var _description: String!
    private var _type: String!
    private var _height: String!
    private var _weight: String!
    private var _defense: String!
    private var _attack: String!
    private var _nextEvotxt: String!
    private var _nextEvoID: String!
    private var _nextEvoLvl: String!
    private var _pokemonURL: String!
    
    
    var nextEvotxt: String{
        
        if _nextEvotxt == nil{
            _nextEvotxt = ""
        }
        return _nextEvotxt
    }
    
    var nextEvoId: String{
        if _nextEvoID == nil {
            _nextEvoID = ""
        }
        return _nextEvoID
    }
    
    var nextEvoLvl: String{
        if _nextEvoLvl == nil {
            _nextEvoLvl = ""
        }
        return _nextEvoLvl
    }
    
    
    
    var description: String{
        
        if _description == nil{
            _description = ""
        }
        return _description
    }
    
    var type: String{
        if _type == nil{
            _type = ""
        }
        return _type
    }
    
    var defense: String{
        
        if _defense == nil{
            _defense = ""
        }
        return _defense
    }
    
    var height: String{
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String{
        if _weight == nil{
            _weight = ""
        }
        return _weight
    }
    
    var attack: String{
        if _attack == nil{
            _attack = ""
        }
        return _attack
    }
    
    
    var name:String{
        return _name
    }
    
    var pokedexid: Int{
        return _pokedexid
    }
    
    init(name: String, pokedexid: Int){
        self._name = name
        self._pokedexid = pokedexid
        
        _pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexid)/"

    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        let url = NSURL(string: _pokemonURL)!
        Alamofire.request(.GET , url).responseJSON { response in
            
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                    
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
            }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        self._type = name.capitalizedString
                    }
                    if types.count > 1 {
                        for var x = 1 ; x < types.count ; x++ {
                            if let name = types[x]["name"] {
                            self._type! += "/\(name.capitalizedString)"
                                
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                
                print(self._type)
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0 {
                    
                    if let url = descArr[0]["resource_uri"] {
                        let NSurl = NSURL(string: "\(URL_BASE)\(url)")!
                        
                        Alamofire.request(.GET, NSurl).responseJSON { response in
                            
                            let descResult = response.result
                            if let descDict = descResult.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    self._description = description
                                    print(self._description)
                                }
                                
                            }
                            
                            completed()
                        }
                    }
                    
                    
                    
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0 {
                    
                    if let to = evolutions[0]["to"] as? String {
                        
                        if to.rangeOfString("mega") == nil {
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                               let str = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                
                                let num = str.stringByReplacingOccurrencesOfString("/", withString: "")
                                self._nextEvoID = num
                                self._nextEvotxt = to
                                
                                if let lvl = evolutions[0]["level"] as? Int {
                                    self._nextEvoLvl = "\(lvl)"
                                }
                                
                                print(self._nextEvoID)
                                print(self.nextEvotxt)
                                print(self.nextEvoLvl)
                                
                            }
                            
                        }
                        
                    }
                    
                    
                }
            
            }
            
        }
            
    }
            
}
        

    
    
    
    
    
    
    
    
