//
//  Mage.swift
//  FrenchGame
//
//  Created by Noblus Mac on 05/04/2020.
//  Copyright © 2020 FrancoisDemichelis. All rights reserved.
//

import Foundation

class Mage: Character {
    
    init(name: String) {
        super.init(name: name, life: 90, weapon: Staff())
        
    }
}
