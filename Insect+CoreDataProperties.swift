//
//  Insect+CoreDataProperties.swift
//  Entomology
//
//  Created by Paul Pacheco on 8/06/23.
//
//

import Foundation
import CoreData


extension Insect {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Insect> {
        return NSFetchRequest<Insect>(entityName: "Insect")
    }

    @NSManaged public var speciesName: String?
    @NSManaged public var urlPhoto: Data?
    @NSManaged public var geoLocate: String?
    @NSManaged public var moreInfoUrl: String?
    @NSManaged public var entomolgist: Entomologist?

}

extension Insect : Identifiable {

}
