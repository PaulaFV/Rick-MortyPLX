//
//  ServicioAPI.swift
//  ProyectoRick
//
//  Created by Paula Fernández Vázquez on 16/5/25.
//

import Foundation
import Combine

class ServicioAPI: ProtocoloAPI {
    func obtenerPersonajes() -> AnyPublisher<[Personaje], Error> {
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        
        return URLSession.shared.dataTaskPublisher(for: url).map(\.data).decode(type: ResultadoPersonaje.self, decoder: JSONDecoder()).map(\.resulatados).eraseToAnyPublisher()
    }
}
