//
//  ProtocoloViewModel.swift
//  ProyectoRick
//
//  Created by Paula Fernández Vázquez on 19/5/25.
//

import Foundation

protocol ProtocoloViewModel {
    func fetchPersonajes()
    func obtenerPersonaje(en indice: Int) -> Personaje
}
