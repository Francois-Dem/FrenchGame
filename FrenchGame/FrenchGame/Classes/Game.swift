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
        // Check "name" in players array
        return self.players.map { $0.name }
    }
    var turn: Int
    
    init(){
        self.players = []
        self.turn = 0
    }
    
    ///check entry name for player and name for character is already in players array with namescheck
    func askName() -> String {
        print("Merci de saisir le nom du personnage")
        if let characterName = readLine() {
            if namescheck.contains(characterName) {
                print("Le nom que vous avez choisi est déja utilisé")
                return askName()
            }
            return characterName
        }
        return askName()
    }
    
    
    
    func teamSelect(player: Player) {
        print("Merci de selectionner 3 personnages pour constituer votre équipe")
        //add character in players array
        players.append(player)
        
        while player.characters.count < 3 {
            print("""
            Quelle classe de personnage souhaitez-vous selectionner ?
            1. ⚔️  Un Guerrier
            2. 🔨  Un Paladin
            3. 🧙‍♂️  Un Magicien
            """)
            let choice = readLine()
            switch choice {
            // warrior
            case "1":
                //create character with askName
                let warrior = Warrior(name: askName())
                player.characters.append(warrior)
            // paladin
            case "2":
                let paladin = Paladin(name: askName())
                player.characters.append(paladin)
            // mage
            case "3":
                let mage = Mage(name: askName())
                player.characters.append(mage)
            default:
                print("Votre choix n'est pas valide")
            }
        }
        
    }
    
    /// Start Game
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
        // End Combat
        endGame()
    }
    
    func endGame() {
        let playerWin = players[0].totalLifeTeam > 0 ? players[0] : players[1]
        print("Le joueur 👤 \(playerWin.name) remporte la partie en \(turn) tours !")

        print("""
            👥 Equipe du joueur 1 \(players[0])
            1. \(players[0].characters[0].name) vie: \(players[0].characters[0].life)
            2. \(players[0].characters[1].name) vie: \(players[0].characters[1].life)
            3. \(players[0].characters[2].name) vie: \(players[0].characters[2].life)
            
            """)

        print("""
            👥 Equipe du joueur 2 \(players[1])
            1. \(players[1].characters[0].name) vie: \(players[1].characters[0].life)
            2. \(players[1].characters[1].name) vie: \(players[1].characters[1].life)
            3. \(players[1].characters[2].name) vie: \(players[1].characters[2].life)
            """)
    }
    
    func playerSelect() {
        print("Merci de saisir votre nom de joueur")
        //check name is not empty
        guard let name = readLine() else {
            playerSelect()
            return
        }
        print("Merci de saisir votre equipe")
        let player = Player(name: name, characters: [])
        teamSelect(player: player)
    }
    
    /// function create team
    func fake(){
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
            // open optional
            let selectedIdx = Int(selected!)! - 1
            let selectedCharacter = player.characters[selectedIdx]
            
            guard selectedCharacter.life > 0 else {
                print("Votre choix n'est pas valide, le personnage est mort")
                return startTurn(player: player)
            }
            randomChest(character: selectedCharacter)
            selectAction(player: player, character: selectedCharacter)
        default:
            print("Votre choix n'est pas valide")
            startTurn(player: player)
        }
    }
    
    func randomChest(character: Character) {
        let randValue = Int.random(in: 1 ... 100)
        // 50 % random chance
        if (randValue < 51) {
            print("""
                   🎲 Un coffre d'arme surprise est apparu ! Voulez-vous l'ouvrir ?
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
                       Quelle action souhaitez-vous faire ?
                       1. ⚔️ Attaquer un personnage adverse
                       2. 💕 Soigner un de vos personnages

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
            
            Quelle est la cible de l'action ?
            1. \(target.characters[0].name) vie: \(target.characters[0].life)
            2. \(target.characters[1].name) vie: \(target.characters[1].life)
            3. \(target.characters[2].name) vie: \(target.characters[2].life)
            """)
        
        let selectedAction = readLine()
        switch selectedAction {
        case "1", "2", "3":
            let selectedIdx = Int(selectedAction!)! - 1
            let targetCharacter = target.characters[selectedIdx]
            
            guard targetCharacter.life > 0 else {
                print("Votre choix n'est pas valide, le personnage est mort")
                return makeAction(from: from, target: target, action: action)
            }
            
            if action == .Attack {
                targetCharacter.life -= from.weapon.damage
                // no negative life
                if targetCharacter.life <= 0 {
                    targetCharacter.life = 0
                }
                print("""
                    \(from.name) inflige à \(targetCharacter.name) \(from.weapon.damage) ⚔️ points de dégâts
                    \(targetCharacter.name) à maintenant: \(targetCharacter.life) ❤️ points de vie
                    """)
            } else if action == .Heal {
                targetCharacter.life += from.weapon.damage
                // overheal
                if targetCharacter.life >= targetCharacter.lifemax {
                    targetCharacter.life = targetCharacter.lifemax
                }
                print("""
                    \(from.name) soigne \(targetCharacter.name) de \(from.weapon.damage) 💕 points de vie
                    \(targetCharacter.name) à maintenant:  \(targetCharacter.life) ❤️ points de vie
                    """)
            }
        default:
            print("Votre choix n'est pas valide")
            makeAction(from: from, target: target, action: action)
        }
        
    }
    
    
}


