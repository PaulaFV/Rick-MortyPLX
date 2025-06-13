//
//  CharactersCellViewModel.swift
//  Ricky-Morty-PLX
//
//  Created by Paula Fernández Vázquez on 29/5/25.
//

import UIKit
import Combine

class CharactersCellViewModel: ObservableObject {
    @Published var image: UIImage?
    let name: String
    private let character: Character
    private let configureUseCase: ConfigureUseCaseProtocol
    private var cancellable: AnyCancellable?
    
    init(character: Character, configureUseCase: ConfigureUseCaseProtocol) {
        self.character = character
        self.name = character.name
        self.configureUseCase = configureUseCase
    }
    
    func loadImage() {
        configureUseCase.recieveImage(url: character.image) { [weak self] image in
            self?.image = image
        }
    }
}
