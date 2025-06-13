//
//  CharactersListViewModel.swift
//  Ricky-Morty-PLX
//
//  Created by Ainhoa  on 26/5/25.
//

import Foundation
import Combine
import CoreData

class CharactersListViewModel: ObservableObject, CharactersListViewModelProtocol {
    
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
        guard !isLoading else { return }
        isLoading = true
        
        apiService.recieveCharacters(url: nextPageURL)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                if case let .failure(error) = completion {
                    print("Failed to fetch characters: \(error)")
                }
            }, receiveValue: { [weak self] result in
                guard let self = self else { return }
                self.nextPageURL = result.info.next
                
                var combinedCharacters = result.results
                if self.nextPageURL == nil || self.characters.isEmpty {
                    let customCharacters = self.loadCustomCharacters()
                    combinedCharacters = customCharacters + combinedCharacters
                }
                
                self.characters.append(contentsOf: combinedCharacters)
                
                let newCellVMs = combinedCharacters.map {
                    CharactersCellViewModel(character: $0, configureUseCase: self.configureUseCase)
                }
                self.cellViewModels.append(contentsOf: newCellVMs)
            })
            .store(in: &cancellables)
    }
    
    func characterCellViewModel(at index: Int) -> CharactersCellViewModel? {
        guard index < cellViewModels.count else { return nil }
        return cellViewModels[index]
    }
    
    func createCustomCharacter(name: String, species: String, gender: String, status: String, image: String, originName: String, locationName: String) {
       
        let context = CustomCharacterManager.shared.container.viewContext
        let newCharacter = EntityCustomCharacter(context: context)
        
        newCharacter.id = Int64(Date().timeIntervalSince1970)
        newCharacter.name = name
        newCharacter.species = species
        newCharacter.gender = gender
        newCharacter.status = status
        newCharacter.image = image
        
        let origin = Origin(name: originName.isEmpty ? "Custom" : originName, url: "")
        let location = Location(name: locationName.isEmpty ? "Unknown" : locationName, url: "")
        newCharacter.origin = try? JSONEncoder().encode(origin)
        newCharacter.location = try? JSONEncoder().encode(location)
        
        do {
            try context.save()
            print("Custom character created")
            
            self.characters.removeAll()
            self.cellViewModels.removeAll()
            self.nextPageURL = nil
            self.loadCharacters()
        } catch {
            print("Error creating custom character: \(error)")
        }
    }
    
    
    private func loadCustomCharacters() -> [Character] {
        let context = CustomCharacterManager.shared.container.viewContext
        let request: NSFetchRequest<EntityCustomCharacter> = EntityCustomCharacter.fetchRequest()
        
        do {
            let customCharacters = try context.fetch(request)
            return customCharacters.map { custom in
                Character(
                    id: Int(custom.id),
                    name: custom.name ?? "Unknown",
                    status: custom.status ?? "Unknown",
                    species: custom.species ?? "Unknown",
                    gender: custom.gender ?? "Unknown",
                    origin: (try? JSONDecoder().decode(Origin.self, from: custom.origin ?? Data())) ?? Origin(name: "?", url: ""),
                    location: (try? JSONDecoder().decode(Location.self, from: custom.location ?? Data())) ?? Location(name: "?", url: ""),
                    image: custom.image ?? ""
                )
            }
        } catch {
            print("Error fetching custom characters: \(error)")
            return []
        }
    }
}
