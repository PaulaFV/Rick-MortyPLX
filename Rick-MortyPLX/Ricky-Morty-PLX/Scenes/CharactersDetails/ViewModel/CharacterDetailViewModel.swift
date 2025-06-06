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
}
