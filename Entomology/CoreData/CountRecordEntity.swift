//
//  CountRecord.swift
//  Entomology
//
//  Created by Paul Pacheco on 8/06/23.
//

import Foundation
import CoreData

class CountRecordEntity: NSManagedObject {}

extension CountRecordEntity {
	@NSManaged var count: Int
	@NSManaged var comment: String
	@NSManaged var geoLocate: String
	@NSManaged var createdAt: Date
	@NSManaged var updatedAt: Date?
	@NSManaged public var insect: Insect?
	@NSManaged public var entomologist: Entomologist?
	@nonobjc public class func fetchRequest() -> NSFetchRequest<CountRecordEntity> {
		return NSFetchRequest<CountRecordEntity>(entityName: "CountRecord")
	}
}

extension CountRecordEntity: Identifiable {}

extension CountRecordEntity: Model {
	static func getByEntomologist() -> NSFetchRequest<CountRecordEntity> {
		let request = CountRecordEntity.fetchRequest()
		request.sortDescriptors = []
		//request.predicate = NSPredicate(format: "entomologist == %@", entomologist)
		return request
	}
	
	static func getByDate() -> NSFetchRequest<CountRecordEntity> {
		let request = CountRecordEntity.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
		return request
	}
}
