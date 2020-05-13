//
//  Paladin.swift
//  FrenchGame
//
//  Created by Noblus Mac on 05/04/2020.
//  Copyright © 2020 FrancoisDemichelis. All rights reserved.
//

import Foundation

class Paladin: Character {
    
    init(name: String) {
        super.init(name: name, life: 50, weapon: Hammer())
        
    }
}
