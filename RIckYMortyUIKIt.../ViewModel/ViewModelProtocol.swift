//
//  ProtocoloViewModel.swift
//  ProyectoRick
//
//  Created by Paula Fernández Vázquez on 19/5/25.
//

import Foundation

protocol ViewModelProtocol {
    func loadCharacters()
    func getCharacters(index: Int) -> Character
}
