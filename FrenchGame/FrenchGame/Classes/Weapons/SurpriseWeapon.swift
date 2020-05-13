//
//  SurpriseWeapon.swift
//  FrenchGame
//
//  Created by Noblus Mac on 29/04/2020.
//  Copyright © 2020 FrancoisDemichelis. All rights reserved.
//

import Foundation
class SurpriseWeapon: Weapon {
    private let newDamage = Int.random(in: 1 ... 100)
    
    init() {
        super.init(damage: newDamage, name: "SurpriseWeapon")
    }
}
