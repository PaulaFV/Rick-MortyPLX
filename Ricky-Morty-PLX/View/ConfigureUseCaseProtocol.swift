//
//  ConfigureUseCaseProtocol.swift
//  Ricky-Morty-PLX
//
//  Created by Paula Fernández Vázquez on 27/5/25.
//

    import Foundation
    import UIKit

    protocol ConfigureUseCaseProtocol {
        func recieveImage(url: String, completion: @escaping (UIImage?) -> Void)
    }
