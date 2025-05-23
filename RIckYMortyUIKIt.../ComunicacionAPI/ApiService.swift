//
//  ServicioAPI.swift
//  ProyectoRick
//
//  Created by Paula Fernández Vázquez on 16/5/25.
//

import Foundation
import Combine

class ApiService: APIProtocol {
    func recieveCharacters(url: String? = nil) -> AnyPublisher<CharacterResult, Error> {
        let urlString = url ?? "https://rickandmortyapi.com/api/character"
        guard let finalURL = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: finalURL)
            .map(\.data)
            .decode(type: CharacterResult.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
