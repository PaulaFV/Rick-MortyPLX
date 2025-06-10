//
//  CharacterFavourite+CoreDataProperties.swift
//  Ricky-Morty-PLX
//
//  Created by Ainhoa  on 4/6/25.
//
//

import Foundation
import CoreData


extension CharacterFavourite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterFavourite> {
        return NSFetchRequest<CharacterFavourite>(entityName: "CharacterFavourite")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var status: String?
    @NSManaged public var species: String?
    @NSManaged public var gender: String?
    @NSManaged public var origin: Data?
    @NSManaged public var location: Data?
    @NSManaged public var image: String?

}

extension CharacterFavourite : Identifiable {

}

extension CharacterFavourite {
    func asignOrigin(origin : Origin) {
        let encoder = JSONEncoder ()
        if let data = try? encoder.encode(origin) {
            self.origin = data
            try? self.managedObjectContext?.save()
        }
    }
    
   func asignLocation(location : Location) {
        let encoder = JSONEncoder ()
        if let data = try? encoder.encode(location) {
            self.location = data
            try? self.managedObjectContext?.save()
        }
    }
}
