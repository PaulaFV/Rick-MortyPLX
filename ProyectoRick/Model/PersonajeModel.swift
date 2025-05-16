//
//  ModelPersonaje.swift
//  ProyectoRick
//
//  Created by Paula Fernández Vázquez on 16/5/25.
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
