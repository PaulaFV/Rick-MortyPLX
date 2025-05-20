//
//  ProtocoloViewModel.swift
//  Rick-MortyPLX-Ainhoa
//
//  Created by Ainhoa  on 20/5/25.
//

import Foundation

protocol ProtocoloViewModel {
    func buscarPersonajes()
    func obtenerPersonaje(en indice: Int) -> Personaje
}
