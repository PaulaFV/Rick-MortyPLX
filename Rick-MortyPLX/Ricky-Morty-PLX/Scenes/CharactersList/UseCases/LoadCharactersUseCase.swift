//
//  LoadCharactersUseCase.swift
//  Ricky-Morty-PLX
//
//  Created by Paula Fernández Vázquez on 27/5/25.
//

import Foundation
import Combine

class LoadCharactersUseCase: LoadCharactersUseCaseProtocol {
    private let apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol) {
        self.apiService = apiService
    }
    
    func execute(url: String?) -> AnyPublisher<CharacterResultModel, any Error> {
        return apiService.recieveCharacters(url: url)
    }
}
