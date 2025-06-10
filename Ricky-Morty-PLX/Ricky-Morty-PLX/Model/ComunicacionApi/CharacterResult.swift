//
//  CharacterResult.swift
//  Ricky-Morty-PLX
//
//  Created by Ainhoa  on 26/5/25.
//

import Foundation

struct CharacterResult: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let next: String?
}

struct Pagination: Codable {
    let next: String?
    let prev: String?
}
