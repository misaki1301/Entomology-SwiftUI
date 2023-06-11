//
//  CountRecord.swift
//  Entomology
//
//  Created by Paul Pacheco on 8/06/23.
//

import Foundation
import CoreData

@objc(CountRecord)
class CountRecord: NSManagedObject {}

extension CountRecord {
	@NSManaged var count: Int
	@NSManaged var comment: String
	@NSManaged var geoLocate: String
	@NSManaged public var insect: Insect?
	@NSManaged public var entomolgist: Entomologist?
	@nonobjc public class func fetchRequest() -> NSFetchRequest<CountRecord> {
		return NSFetchRequest<CountRecord>(entityName: "CountRecord")
	}
}
//extension Insect: Model {
//	static func getByEntomologist(for entomologist: Entomologist) -> NSFetchRequest<Insect> {
//		let request = Insect.fetchRequest()
//		request.sortDescriptors = []
//		request.predicate = NSPredicate(
//	}
//}
extension CountRecord: Model {
	static func getByEntomologist(for entomologist: Entomologist) -> NSFetchRequest<CountRecord> {
		let request = CountRecord.fetchRequest()
		request.sortDescriptors = []
		request.predicate = NSPredicate(format: "entomologist == %@", entomologist)
		return request
	}
}
