//
//  ConfigureUseCase.swift
//  Ricky-Morty-PLX
//
//  Created by Paula Fernández Vázquez on 27/5/25.
//

import UIKit
import Foundation
import Combine

class ConfigureUseCase: ConfigureUseCaseProtocol {

    private let apiService: ApiServiceProtocol
    private let imageDownloader: ImageDownloaderProtocol
    private var subscriptions = Set<AnyCancellable>()


    init(apiService: ApiServiceProtocol, imageDownloader: ImageDownloaderProtocol) {
        self.apiService = apiService
        self.imageDownloader = imageDownloader
    }

    func recieveImage(url: String, completion: @escaping (UIImage?) -> Void) {
        imageDownloader.downloadImage(from: url)
            .receive(on: DispatchQueue.main)
            .sink { image in
                completion(image)
            }
            .store(in: &subscriptions)
    }
    
    func recieveImage(url: String) -> AnyPublisher<UIImage?, Never> {
        imageDownloader.downloadImage(from: url)
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func makeCellViewModel(from character: Character) -> CharactersCellViewModel {
        return CharactersCellViewModel(character: character, configureUseCase: self)
    }
}
