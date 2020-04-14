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
    
    init(){
        self.players = []
    }
    
    // askName
    // Dans la fonction verifier si nom déjà existant
    // Pour chaque player dans players puis pour chaque character dans player.characters
    func askName() -> String {
        print("Merci de saisir le nom du personnage")
        if let nameCharacter = readLine() {
            return nameCharacter
        }
        return askName()
    }
    
    
    
    func teamSelect(player: Player) {
        print("Merci de selectionner 3 personnages pour constituer votre équipe")
        players.append(player) // Ajoute un joueur dans le tableau players
        
        while player.characters.count < 3 {
            print("""
            Quelle classe de personnage souhaitez vous selectionner ?
            1. ⚔️  Un Guerrier
            2. 🔨  Un Paladin
            3. 🧙‍♂️  Un Magicien
            """)
            let choice = readLine()
            switch choice {
                case "1": // warrior
                    //Saisie avec function askName
                    let warrior = Warrior(name: askName())
                    player.characters.append(warrior)
                case "2": // paladin
                    let paladin = Paladin(name: askName())
                    player.characters.append(paladin)
                case "3": // mage
                    let mage = Mage(name: askName())
                    player.characters.append(mage)
                default:
                    print("Votre choix n'est pas valide")
            }
        }
    }
    
    
    func start() {
        print("Début de la partie")
        while players.count < 2 {
            playerSelect()
        }
    }
    
    func playerSelect() {
        print("Merci de saisir votre nom")
        guard let name = readLine() else {  // verifie que name n'est pas vide
            playerSelect()
            return
        }
        print("merci de saisir votre equipe")
        let player = Player(name: name, characters: [])
        teamSelect(player: player)
    }
    
    func fake(){
        
    }
    
}


