//
//  ProtocoloAPI.swift
//  Rick-MortyPLX-Ainhoa
//
//  Created by Ainhoa  on 20/5/25.
//

import Foundation
import Combine

protocol ProtocoloAPI {
    func obtenerPersonajes() -> AnyPublisher<[Personaje], Error>
}
