//
//  LoadCharactersUseCaseProtocol.swift
//  Ricky-Morty-PLX
//
//  Created by Paula Fernández Vázquez on 27/5/25.
//

import Foundation
import Combine

protocol LoadCharactersUseCaseProtocol {
    func execute(url: String?) -> AnyPublisher<CharacterResultModel, Error>
}
