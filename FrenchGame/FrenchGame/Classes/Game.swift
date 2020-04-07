//
//  Game.swift
//  FrenchGame
//
//  Created by Noblus Mac on 30/03/2020.
//  Copyright © 2020 FrancoisDemichelis. All rights reserved.
//

import Foundation

class Game {
    var players: [Player]
    
    init(players: [Player]){
        self.players = []
    }
    
    func teamSelect(player: Player) {
        print("Merci de selectionner 3 personnages pour constituer votre équipe")
        print("""
        Quelle classe de personnage souhaitez vous selectionner ?
        1. ⚔️  Un Guerrier
        2. 🔨  Un Paladin
        3. 🧙‍♂️  Un Magicien
        """)
        let choice = readLine()
        switch choice {
        case "1": // warrior
            player.characters.append(Warrior())
        case "2": // paladin
            player.characters.append(Paladin())
        case "3": // mage
            player.characters.append(Mage())
        default:
            print("Votre choix n'est pas valide")
            teamSelect(player: player)
        }
    }
    
    
    func start() {
        while players.count < 2 {
            playerSelect()
        }
    }
    
    func playerSelect() {
        print("Joueur merci de saisir votre nom")
        guard let name = readLine() else {
            playerSelect()
            return
        }
        print("merci de saisir votre equipe")
        teamSelect(player: Player(name: name, characters: []))
    }
}


