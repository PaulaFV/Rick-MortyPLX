//
//  APIProtocol.swift
//  Ricky-Morty-PLX
//
//  Created by Ainhoa  on 26/5/25.
//

import Foundation
import Combine

protocol ApiServiceProtocol {
    func recieveCharacters(url: String?) -> AnyPublisher<CharacterResultModel, Error>
}
