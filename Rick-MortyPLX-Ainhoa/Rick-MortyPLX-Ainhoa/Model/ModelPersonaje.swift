//
//  ModelPersonaje.swift
//  Rick-MortyPLX-Ainhoa
//
//  Created by Ainhoa  on 19/5/25.
//

import Foundation

struct Personaje: Codable {
    let nombre: String
    let id: Int
    let estado : String
    let especie : String
    let genero : String
    let origen : Origen
    let localizacion : Localizacion
    let imagen : String
}
