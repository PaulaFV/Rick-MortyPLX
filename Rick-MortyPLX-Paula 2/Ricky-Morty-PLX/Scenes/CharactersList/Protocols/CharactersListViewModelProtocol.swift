//
//  ViewModelProtocol.swift
//  Ricky-Morty-PLX
//
//  Created by Ainhoa  on 26/5/25.
//

import Foundation

protocol charactersListViewModelProtocol {
    func loadCharacters()
    func characterCellViewModel(index: Int) -> Character?
    func selectedCharacter(index: Int)
}
