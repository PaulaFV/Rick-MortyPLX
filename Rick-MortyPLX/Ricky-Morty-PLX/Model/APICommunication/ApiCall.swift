//
//  ApiService.swift
//  Ricky-Morty-PLX
//
//  Created by Ainhoa  on 26/5/25.
//

import Foundation
import Combine

final class ApiCall: ApiServiceProtocol {
    func recieveCharacters(url: String? = nil) -> AnyPublisher<CharacterResultModel, Error> {
        let urlString = url ?? "https://rickandmortyapi.com/api/character"
        guard let finalURL = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: finalURL)
            .map(\.data)
            .decode(type: CharacterResultModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
