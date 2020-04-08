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
    
    // func Name Personnage
    func askName(message: String) -> String {
        guard let nameCharacter = readLine() else {
            return "No name"
        }
        return nameCharacter
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
                    let warrior = Warrior()
                    // Externaliser dans une fonction avec 1 parametr de type string (message)
                    // Dans la fonction verifier si nom déjà existant
                    // Pour chaque player dans players puis pour chaque character dans player.characters
                    print("Merci de saisir le nom du personnage")
                    guard let nameCharacter = readLine() else {
                        teamSelect(player: player)
                        return
                    }
                    // Fin ext
                    warrior.name = askName(message: "Merci de saisir le nom du personnage")
                    player.characters.append(warrior)
                case "2": // paladin
                    player.characters.append(Paladin())
                case "3": // mage
                    player.characters.append(Mage())
                default:
                    print("Votre choix n'est pas valide")
            }
        }
    }
    
    
    func start() {
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
        teamSelect(player: Player(name: name, characters: []))
    }
}


