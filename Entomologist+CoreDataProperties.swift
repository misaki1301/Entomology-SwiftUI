//
//  Entomologist+CoreDataProperties.swift
//  Entomology
//
//  Created by Paul Pacheco on 8/06/23.
//
//

import CoreData
import Foundation

public extension Entomologist {
	@nonobjc class func fetchRequest() -> NSFetchRequest<Entomologist> {
		return NSFetchRequest<Entomologist>(entityName: "Entomologist")
	}

	@NSManaged var geoLocate: String?
	@NSManaged var name: String?
	@NSManaged var urlPhoto: Data?
	@NSManaged var insects: NSSet?
}

// MARK: Generated accessors for insects

public extension Entomologist {
	@objc(addInsectsObject:)
	@NSManaged func addToInsects(_ value: Insect)

	@objc(removeInsectsObject:)
	@NSManaged func removeFromInsects(_ value: Insect)

	@objc(addInsects:)
	@NSManaged func addToInsects(_ values: NSSet)

	@objc(removeInsects:)
	@NSManaged func removeFromInsects(_ values: NSSet)
}

extension Entomologist: Identifiable {}
