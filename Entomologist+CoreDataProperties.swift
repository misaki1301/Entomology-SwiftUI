//
//  Entomologist+CoreDataProperties.swift
//  Entomology
//
//  Created by Paul Pacheco on 8/06/23.
//
//

import Foundation
import CoreData


extension Entomologist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entomologist> {
        return NSFetchRequest<Entomologist>(entityName: "Entomologist")
    }

    @NSManaged public var geoLocate: String?
    @NSManaged public var name: String?
    @NSManaged public var urlPhoto: Data?
    @NSManaged public var insects: NSSet?

}

// MARK: Generated accessors for insects
extension Entomologist {

    @objc(addInsectsObject:)
    @NSManaged public func addToInsects(_ value: Insect)

    @objc(removeInsectsObject:)
    @NSManaged public func removeFromInsects(_ value: Insect)

    @objc(addInsects:)
    @NSManaged public func addToInsects(_ values: NSSet)

    @objc(removeInsects:)
    @NSManaged public func removeFromInsects(_ values: NSSet)

}

extension Entomologist : Identifiable {

}
