//
//  CustomCharacterManager.swift
//  Ricky-Morty-PLX
//
//  Created by Paula Fernández Vázquez on 13/6/25.
//

import Foundation
import CoreData

class CustomCharacterManager {
    static let shared = CustomCharacterManager()
    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "CustomCharacterEntiti")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load custom character store: \(error)")
            }
        }
    }
}
