//
//  ViewModelProtocol.swift
//  Ricky-Morty-PLX
//
//  Created by Ainhoa  on 26/5/25.
//

import Foundation

protocol ViewModelProtocol {
    func loadCharacters()
    func getCharacters(index: Int) -> Character
}
