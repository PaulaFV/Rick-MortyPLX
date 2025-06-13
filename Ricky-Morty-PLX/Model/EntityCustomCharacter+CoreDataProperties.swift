//
//  EntityCustomCharacter+CoreDataProperties.swift
//  Ricky-Morty-PLX
//
//  Created by Paula Fernández Vázquez on 13/6/25.
//
//

import Foundation
import CoreData


extension EntityCustomCharacter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntityCustomCharacter> {
        return NSFetchRequest<EntityCustomCharacter>(entityName: "EntityCustomCharacter")
    }

    @NSManaged public var gender: String?
    @NSManaged public var id: Int64
    @NSManaged public var image: String?
    @NSManaged public var location: Data?
    @NSManaged public var name: String?
    @NSManaged public var origin: Data?
    @NSManaged public var species: String?
    @NSManaged public var status: String?

}

extension EntityCustomCharacter : Identifiable {

}
