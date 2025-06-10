//
//  CharacterDetailViewModel.swift
//  Ricky-Morty-PLX
//
//  Created by Ainhoa  on 26/5/25.
//

import Foundation

class CharacterDetailViewModel {
    private let character : Character
    
    init(character: Character) {
        self.character = character
    }
    
    var name : String { character.name }
    var status : String { character.status }
    var species : String { character.species }
    var gender : String { character.gender }
    var origin : String { character.origin.name }
    var location : String { character.location.name }
    var imageURL : URL? { URL(string: character.image ) }
}
