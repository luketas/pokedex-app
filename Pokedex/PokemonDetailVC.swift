//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Lucas Franco on 3/29/16.
//  Copyright © 2016 Lucas Franco. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var MainImg: UIImageView!
    @IBOutlet weak var DescriptionLbl: UILabel!
    @IBOutlet weak var Typelbl: UILabel!
    @IBOutlet weak var DefenseLbl: UILabel!
    @IBOutlet weak var HeightLbl: UILabel!
    @IBOutlet weak var WeightLbl: UILabel!
    @IBOutlet weak var PokeIdLbl: UILabel!
    @IBOutlet weak var BaseAttLbl: UILabel!
    @IBOutlet weak var EvolutionLbl: UILabel!
    @IBOutlet weak var currentoEvoImg: UIImageView!
    @IBOutlet weak var nextEvoLbl: UIImageView!
    
    
    
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      namelbl.text = pokemon.name
    let img = UIImage(named: "\(pokemon.pokedexid)")
        MainImg.image = img
        currentoEvoImg.image = img
      
        
        pokemon.downloadPokemonDetails { 
            () -> () in
            
            self.updateUI()
        }
    
    
    }
    
        func updateUI() {
                DescriptionLbl.text = pokemon.description
                HeightLbl.text = pokemon.height
                WeightLbl.text = pokemon.weight
            DefenseLbl.text = pokemon.defense
            BaseAttLbl.text = pokemon.attack
            Typelbl.text = pokemon.type
            PokeIdLbl.text = "\(pokemon.pokedexid)"
            
            if pokemon.nextEvoId == ""{
                EvolutionLbl.text = "No Evolution"
                nextEvoLbl.hidden = true
            } else {
                nextEvoLbl.hidden = false
            nextEvoLbl.image = UIImage(named: pokemon.nextEvoId)
                var str = "Next Evolution: \(pokemon.nextEvotxt)"
                
                if pokemon.nextEvoLvl != "" {
                    str += " - LVL \(pokemon.nextEvoLvl)"
                    EvolutionLbl.text = str
                }
            }
            
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
        
    
    
    @IBAction func BackBtn(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
