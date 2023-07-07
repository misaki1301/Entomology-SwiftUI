//
//  Insect+CoreDataProperties.swift
//  Entomology
//
//  Created by Paul Pacheco on 8/06/23.
//
//

import CoreData
import Foundation

public extension Insect {
	@nonobjc class func fetchRequest() -> NSFetchRequest<Insect> {
		return NSFetchRequest<Insect>(entityName: "Insect")
	}

	@NSManaged var speciesName: String?
	@NSManaged var urlPhoto: Data?
	@NSManaged var geoLocate: String?
	@NSManaged var moreInfoUrl: String?
	@NSManaged var entomolgist: Entomologist?
}

extension Insect: Identifiable {}
