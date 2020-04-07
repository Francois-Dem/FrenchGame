//
//  Player.swift
//  FrenchGame
//
//  Created by Noblus Mac on 30/03/2020.
//  Copyright © 2020 FrancoisDemichelis. All rights reserved.
//

import Foundation

// create player class
class Player {
    var name: String
    var characters: [Character]
    
    init(name: String, characters: [Character]) {
        self.name = name
        self.characters = []
    }
}

