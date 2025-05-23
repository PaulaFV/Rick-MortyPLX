//
//  ModelPersonaje.swift
//  ProyectoRick
//
//  Created by Paula Fernández Vázquez on 16/5/25.
//

import Foundation

struct Character: Codable,Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
}
