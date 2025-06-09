//
//  CharacterFavouriteManager.swift
//  Ricky-Morty-PLX
//
//  Created by Ainhoa  on 9/6/25.
//

import Foundation
import CoreData


class CharacterFavouriteManager {
    static let shared = CharacterFavouriteManager()
    let container : NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "CharacterFavourite")
        container.loadPersistentStores {
            _, error in if let error = error {
                fatalError("Error loading store: \(error)")
            }
        }
    }
    
    func isFavourite(id: Int) -> Bool {
        let context = container.viewContext
        let fetch = CharacterFavourite.fetchRequest()
        fetch.predicate = NSPredicate(format: "id == %d", id)
        let count = (try? context.count(for: fetch)) ?? 0
        return count > 0
    }
    
    func toggleFavourite(character : Character) {
        let context = container.viewContext
        let fetch = CharacterFavourite.fetchRequest()
        fetch.predicate = NSPredicate(format: "id == %d", character.id)
        
        if let existing = try? context.fetch(fetch),
           let fav = existing.first {
            context.delete(fav)
        } else {
            let fav = CharacterFavourite(context: context)
            fav.id = Int64(character.id)
            fav.name = character.name
            fav.gender = character.gender
            fav.species = character.species
            fav.status = character.status
            fav.image = character.image
            fav.asignOrigin(origin: character.origin)
            fav.asignLocation(location: character.location)
        }
        
        
        try? context.save()
    }
    
    func fetchAllFavourites() -> [CharacterFavourite] {
        let context = container.viewContext
        let request: NSFetchRequest<CharacterFavourite> = CharacterFavourite.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching favourites: \(error)")
            return []
        }
    }
}
