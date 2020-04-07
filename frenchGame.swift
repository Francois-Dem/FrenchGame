// create player class
class Player {
    
}

// create character class
class Character {
    var characterName: String        /* Utiliser un optionnel? String? */
    var characterLife: Int           /* Int8 ? */
    var characterWeapon: String
    
    init (characterName: String) {    /* Initialiseur */
        self.characterName = characterName
    }
    
}




func createCharacterName() {
    /* le joueur doit donner un nom à un perso mais ce nom de doit pas déja exister */
}

// character Name
var onecharacterName = readLine()



// start game
func createTeam() {
    print("Merci de choisir un nom pour votre personnage")
    
    if let characterName = readLine() {
        print ("le nom de votre 1er personnage est \(characterName) ")
    }
        
}
