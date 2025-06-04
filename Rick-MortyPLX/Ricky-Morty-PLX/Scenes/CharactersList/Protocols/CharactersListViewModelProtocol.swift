//
//  ViewModelProtocol.swift
//  Ricky-Morty-PLX
//
//  Created by Ainhoa  on 26/5/25.
//

import Foundation

protocol CharactersListViewModelProtocol {
    func loadCharacters()
    func characterCellViewModel(at index: Int) -> CharactersCellViewModel?
}
