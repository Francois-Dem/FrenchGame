//
//  Warrior.swift
//  FrenchGame
//
//  Created by Noblus Mac on 30/03/2020.
//  Copyright © 2020 FrancoisDemichelis. All rights reserved.
//

import Foundation

class Warrior: Character {
    
    init(name: String) {
        super.init(name: name, life: 100, weapon: Sword())
    }
}

