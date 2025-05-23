//
//  ResultadoPersonaje.swift
//  ProyectoRick
//
//  Created by Paula Fernández Vázquez on 16/5/25.
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
