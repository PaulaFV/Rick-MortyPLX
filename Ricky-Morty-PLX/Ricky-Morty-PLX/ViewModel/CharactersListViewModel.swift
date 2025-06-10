//
//  CharactersListViewModel.swift
//  Ricky-Morty-PLX
//
//  Created by Ainhoa  on 26/5/25.
//

import Foundation
import Combine

class CharactersListViewModel: ObservableObject, ViewModelProtocol {
    @Published var characters: [Character] = []
    private var nextURL: String? = nil
    private var loading = false
    private var cancelables = Set<AnyCancellable>()
    private let apiService: APIProtocol

    init(apiService: APIProtocol = ApiService()) {
        self.apiService = apiService
    }

    func loadCharacters() {
        guard !loading else { return }
        loading = true
        apiService.recieveCharacters(url: nextURL)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(let error) = completion {
                    print("Error trying to load characters: \(error.localizedDescription)")
                }
                self?.loading = false
            }, receiveValue: { [weak self] result in
                self?.characters.append(contentsOf: result.results)
                self?.nextURL = result.info.next
                self?.loading = false
            })
            .store(in: &cancelables)
    }

    var count: Int {
        return characters.count
    }

    func getCharacters(index: Int) -> Character {
        return characters[index]
    }
}
