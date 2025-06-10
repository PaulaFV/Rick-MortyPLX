//
//  APIProtocol.swift
//  Ricky-Morty-PLX
//
//  Created by Ainhoa  on 26/5/25.
//

import Foundation
import Combine

protocol APIProtocol {
    func recieveCharacters(url: String?) -> AnyPublisher<CharacterResult, Error>
}
