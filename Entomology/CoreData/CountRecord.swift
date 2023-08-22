//
//  CountRecord.swift
//  Entomology
//
//  Created by Paul Pacheco on 8/06/23.
//

import Foundation
import CoreData

class CountRecord: NSManagedObject {}

extension CountRecord {
	@NSManaged var count: Int
	@NSManaged var comment: String
	@NSManaged var location: String
	@NSManaged var createdAt: Date
	@NSManaged var updatedAt: Date?
	@NSManaged public var insect: Insect?
	@NSManaged public var entomologist: Entomologist?
	@NSManaged public var geolocate: GeoLocate?
	@nonobjc public class func fetchRequest() -> NSFetchRequest<CountRecord> {
		return NSFetchRequest<CountRecord>(entityName: "CountRecord")
	}
}

extension CountRecord: Identifiable {}

extension CountRecord: Model {
	static func getByEntomologist() -> NSFetchRequest<CountRecord> {
		let request = CountRecord.fetchRequest()
		request.sortDescriptors = []
		//request.predicate = NSPredicate(format: "entomologist == %@", entomologist)
		return request
	}
	
	static func getByDate() -> NSFetchRequest<CountRecord> {
		let request = CountRecord.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
		return request
	}
	
	static func getByName(for searchTerm: String) -> NSFetchRequest<CountRecord> {
		let request = CountRecord.fetchRequest()
		request.predicate = NSCompoundPredicate(format: "insect.speciesName == %@", searchTerm)
		request.sortDescriptors = []
		return request
	}
}
