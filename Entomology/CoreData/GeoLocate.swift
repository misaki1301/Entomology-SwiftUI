//
//  GeoLocate.swift
//  Entomology
//
//  Created by Paul Pacheco on 4/07/23.
//

import Foundation
import CoreData

class GeoLocate: NSManagedObject {}

extension GeoLocate {
	@NSManaged var latitude: Double
	@NSManaged var longitude: Double
	@NSManaged var countRecords: NSSet?
	@nonobjc public class func fetchRequest() -> NSFetchRequest<Insect> {
		return NSFetchRequest<Insect>(entityName: "GeoLocate")
	}
}

extension GeoLocate: Identifiable {}

extension GeoLocate: Model {
	
}
