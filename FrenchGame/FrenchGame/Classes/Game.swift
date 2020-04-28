//
//  Game.swift
//  FrenchGame
//
//  Created by Noblus Mac on 30/03/2020.
//  Copyright © 2020 FrancoisDemichelis. All rights reserved.
//

import Foundation

class Game {
    let ACTION_ATTACK: Int = 0
    let ACTION_HEAL: Int = 1
    
    var players: [Player]
    var namescheck: [String] {
        return self.players.map { $0.name } // check dans le tableau la valeur name
    }
    
    init(){ // suppression des paramétres de cet init pour que le main fonctionne
        self.players = []
    }
    
    // askName
    // Dans la fonction verifier si nom déjà existant
    // Pour chaque player dans players puis pour chaque character dans player.characters
    func askName() -> String {
        print("Merci de saisir le nom du personnage")
        if let characterName = readLine() {
            if namescheck.contains(characterName) { // test si entrée déja présente
                print("Le nom que vous avez choisi est déja utilisé")
                return askName()
            }
            return characterName
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
        print("début des combats")
        var turn = 0
        while (players[0].totalLifeTeam > 0 && players[1].totalLifeTeam > 0) {
            turn += 1
            startTurn(player: self.players[0])
            startTurn(player: self.players[1])
        }
        // Fin de partie
        //var totalhp: Int = player.totalLifeTeam  // meme func mais avec reduce
    }
    
    /*func countLife (player: Player) -> Int {
        return player.characters[0].life + player.characters[1].life + player.characters[2].life
    }*/
    
    
    func playerSelect() {
        print("Merci de saisir votre nom de joueur")
        guard let name = readLine() else {  // verifie que name n'est pas vide
            playerSelect()
            return
        }
        print("merci de saisir votre equipe")
        let player = Player(name: name, characters: [])
        teamSelect(player: player)
    }
    
    func fake(){ // fonction de génération d'équipe
        let player = Player(name: "joueur 1", characters: [])
        player.characters.append(Warrior(name: "warrior"))
        player.characters.append(Paladin(name: "paladin"))
        player.characters.append(Mage(name: "mage"))
        players.append(player)
        let player2 = Player(name: "joueur 2", characters: [])
        player2.characters.append(Warrior(name: "warrior2"))
        player2.characters.append(Paladin(name: "paladin2"))
        player2.characters.append(Mage(name: "mage2"))
        players.append(player2)
        print(players) // print pour vérifier le bon fonctionnement de la fonction
    }

    func startTurn(player: Player) {
        if (player.totalLifeTeam <= 0) {
            return
        }
        print("""
            
        👤 \(player.name) Avec quel personnage souhaitez-vous jouer ?
        1. \(player.characters[0].name) vie: \(player.characters[0].life)
        2. \(player.characters[1].name) vie: \(player.characters[1].life)
        3. \(player.characters[2].name) vie: \(player.characters[2].life)
        """)
        
        let selected = readLine()
        switch selected {
            case "1", "2", "3":
                let selectedIdx = Int(selected!)! - 1 // ouverture d'un optionel
                
                print("""
                Quelle action souhaitez vous faire ?
                1. Attaquer un personnage adverse
                2. Soigner un de vos personnage
                """)
                let action = readLine()
                switch action {
                case "1":
                    let inactive = players.filter { $0.name != player.name }[0]
                    makeAction(from: player.characters[selectedIdx], target: inactive, action: ACTION_ATTACK)
                case "2":
                    makeAction(from: player.characters[selectedIdx], target: player, action: ACTION_HEAL)
                default:
                    print("Votre choix n'est pas valide")
                }
            default:
                print("Votre choix n'est pas valide")
        }
    }
    
    
    func makeAction(from: Character, target: Player, action: Int) {
        print("""
        Quel est la cible de l'action ?
        1. \(target.characters[0].name) vie: \(target.characters[0].life)
        2. \(target.characters[1].name) vie: \(target.characters[1].life)
        3. \(target.characters[2].name) vie: \(target.characters[2].life)
        """)
        
        let selectedAction = readLine()
        switch selectedAction {
            case "1", "2", "3":
                let selectedIdx = Int(selectedAction!)! - 1
                let targetCharacter = target.characters[selectedIdx]
            
            if action == ACTION_ATTACK {
                targetCharacter.life -= from.weapon.damage
                print("""
                    \(from.name) inflige à \(targetCharacter.name) \(from.weapon.damage) points de dégats
                    \(targetCharacter.name) à maintenant: \(targetCharacter.life) points de vie
                """)
            } else if action == ACTION_HEAL {
                targetCharacter.life += from.weapon.damage
                print("""
                    \(from.name) soigne \(targetCharacter.name) de \(from.weapon.damage) points de vie
                    \(targetCharacter.name) à maintenant:  \(targetCharacter.life) points de vie
                """)
            }
            default:
                print("Votre choix n'est pas valide")
        }
        
    }
    
    
}


