//
//  ProtocoloAPI.swift
//  ProyectoRick
//
//  Created by Paula Fernández Vázquez on 16/5/25.
//

import Foundation
import Combine

protocol ProtocoloAPI {
    func obtenerPersonajes() -> AnyPublisher<[Personaje], Error>
}
