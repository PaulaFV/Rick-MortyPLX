//
//  CharacterDetailViewModel.swift
//  Ricky-Morty-PLX
//
//  Created by Paula Fernández Vázquez on 4/6/25.
//

import Foundation
import UIKit

class CharacterDetailViewModel {
    
    let character: Character
    let characterFavouriteManager = CharacterFavouriteManager.shared
    var onImageLoaded: ((UIImage?) -> Void)?
    
    init(character: Character) {
        self.character = character
    }
    
    func loadImage() {
        guard let url = URL(string: character.image) else {
            onImageLoaded?(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    self.onImageLoaded?(nil)
                }
                return
            }
            DispatchQueue.main.async {
                self.onImageLoaded?(image)
            }
        }.resume()
    }
    
    func isFavourite() -> Bool {
        characterFavouriteManager.isFavourite(id: character.id)
       
    }
    
    func toggleFavourite() {
        characterFavouriteManager.toggleFavourite(character: character)
    }
}

