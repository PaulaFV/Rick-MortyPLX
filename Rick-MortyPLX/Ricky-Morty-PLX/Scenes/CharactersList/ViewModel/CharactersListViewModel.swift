//
//  CharactersListViewModel.swift
//  Ricky-Morty-PLX
//
//  Created by Ainhoa  on 26/5/25.
//

import Foundation
import Combine

class CharactersListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    

    private var cancellables = Set<AnyCancellable>()
    private let apiService: ApiServiceProtocol
    private let imageDownloader: ImageDownloaderProtocol
    private var nextPageURL: String? = nil
    private var isLoading = false
    private let configureUseCase: ConfigureUseCaseProtocol


    init(apiService: ApiServiceProtocol, imageDownloader: ImageDownloaderProtocol, configureUseCase: ConfigureUseCaseProtocol) {
        self.apiService = apiService
        self.imageDownloader = imageDownloader
        self.configureUseCase = configureUseCase
    }

    private var cellViewModels: [CharactersCellViewModel] = []
   

    func loadCharacters() {
        // ... when you receive new characters
        apiService.recieveCharacters(url: nextPageURL)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    print("Failed to fetch characters: \(error)")
                }
            }, receiveValue: { [weak self] result in
                guard let self = self else { return }
                self.characters.append(contentsOf: result.results)
                // Create new cellViewModels for this characters
                let newCellVMs = result.results.map { character in
                    CharactersCellViewModel(character: character, configureUseCase: self.configureUseCase)
                }
                self.cellViewModels.append(contentsOf: newCellVMs)
                self.nextPageURL = result.info.next
            })
            .store(in: &cancellables)
    }

    func characterCellViewModel(at index: Int) -> CharactersCellViewModel? {
        guard index < cellViewModels.count else { return nil }
        return cellViewModels[index]
    }
    
}
