//
//  Game.swift
//  FrenchGame
//
//  Created by Noblus Mac on 30/03/2020.
//  Copyright © 2020 FrancoisDemichelis. All rights reserved.
//

import Foundation

class Game {
    enum ActionType: Int {
        case Attack
        case Heal
    }
    
    var players: [Player]
    var namescheck: [String] {
        return self.players.map { $0.name } // check dans le tableau la valeur name
    }
    var turn: Int
    
    init(){ // suppression des paramétres de cet init pour que le main fonctionne
        self.players = []
        self.turn = 0
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
        print("Début des combats")
        while (players[0].totalLifeTeam > 0 && players[1].totalLifeTeam > 0) {
            turn += 1
            startTurn(player: self.players[0])
            startTurn(player: self.players[1])
        }
        // Fin de partie
        endGame()
    }
    
    func endGame() {
        // Test du joueur gagnant (totalLifeTeam > 0) -> Print nom du joueur gagnant
        // Print nombres de tour
        // Print équipe J1
        // Print équipe J2
    }
    
    func playerSelect() {
        print("Merci de saisir votre nom de joueur")
        guard let name = readLine() else {  // verifie que name n'est pas vide
            playerSelect()
            return
        }
        print("Merci de saisir votre equipe")
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
        guard player.totalLifeTeam > 0 else {
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
            randomChest(character: player.characters[selectedIdx])
            selectAction(player: player, character: player.characters[selectedIdx])
        default:
            print("Votre choix n'est pas valide")
            startTurn(player: player)
        }
    }
    
    func randomChest(character: Character) {
        let randValue = Int.random(in: 1 ... 100)
        if (randValue < 30) {
            print("""
                   🎲 Un coffre d'arme surprise est apparu ! Voulez vous l'ouvrir ?
                    1. Ouvrir
                    2. Ne pas ouvrir
                """)
            let open = readLine()
            switch open {
            case "1":
                character.weapon = SurpriseWeapon()
                break
            case "2":
                break
            default:
                print("Votre choix n'est pas valide")
                randomChest(character: character)
            }
        }
    }
    
    func selectAction(player: Player, character: Character) {
        print("""
                       Quelle action souhaitez vous faire ?
                       1. Attaquer un personnage adverse
                       2. Soigner un de vos personnage
                       """)
        let action = readLine()
        switch action {
        case "1":
            let inactive = players.first { $0.name != player.name }!
            makeAction(from: character, target: inactive, action: .Attack)
        case "2":
            makeAction(from: character, target: player, action: .Heal)
        default:
            print("Votre choix n'est pas valide")
            selectAction(player: player, character: character)
        }
    }
    
    func makeAction(from: Character, target: Player, action: ActionType) {
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
            
            if action == .Attack {
                targetCharacter.life -= from.weapon.damage
                print("""
                    \(from.name) inflige à \(targetCharacter.name) \(from.weapon.damage) points de dégats
                    \(targetCharacter.name) à maintenant: \(targetCharacter.life) points de vie
                    """)
            } else if action == .Heal {
                targetCharacter.life += from.weapon.damage
                print("""
                    \(from.name) soigne \(targetCharacter.name) de \(from.weapon.damage) points de vie
                    \(targetCharacter.name) à maintenant:  \(targetCharacter.life) points de vie
                    """)
            }
        default:
            print("Votre choix n'est pas valide")
            makeAction(from: from, target: target, action: action)
        }
        
    }
    
    
}


