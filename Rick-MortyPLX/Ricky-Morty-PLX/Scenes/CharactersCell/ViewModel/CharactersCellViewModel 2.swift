//
//  CharactersCellViewModel 2.swift
//  Ricky-Morty-PLX
//
//  Created by Paula Fernández Vázquez on 30/5/25.
//


import UIKit
import Combine

class CharactersCellViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    let name: String
    private let imageURL: String
    private var cancellables = Set<AnyCancellable>()
    private let configureUseCase: ConfigureUseCaseProtocol

    init(character: Character, configureUseCase: ConfigureUseCaseProtocol) {
        self.name = character.name
        self.imageURL = character.image
        self.configureUseCase = configureUseCase
        loadImage()
    }

    private func loadImage() {
        configureUseCase.recieveImage(url: imageURL) { [weak self] image in
            self?.image = image
        }
    }
}
