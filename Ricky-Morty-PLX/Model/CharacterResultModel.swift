//
//  CharacterResult.swift
//  Ricky-Morty-PLX
//
//  Created by Ainhoa  on 26/5/25.
//

import Foundation

struct CharacterResultModel: Codable {
    let info: InfoModel
    let results: [Character]
}
