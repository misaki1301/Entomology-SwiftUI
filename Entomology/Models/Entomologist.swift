//
//  ModelEntomologist.swift
//  Entomology
//
//  Created by Paul Pacheco on 1/06/23.
//

import CoreData
import Foundation

@objc(Entomologist)
public class Entomologist: NSManagedObject {
	func changeUrlPhoto(type: String) {}

	func changeGeoLocationPhoto() {}
}

public extension Entomologist {
	@NSManaged var name: String?
	@NSManaged var urlPhoto: Data?
	@NSManaged var geoLocate: String?
	@NSManaged var countRecords: NSSet?
	@nonobjc class func fetchRequest() -> NSFetchRequest<Entomologist> {
		return NSFetchRequest<Entomologist>(entityName: "Entomologist")
	}
}

extension Entomologist: Identifiable {}

extension Entomologist: Model {
	static func getById(for objectId: NSManagedObjectID) -> NSFetchRequest<Entomologist> {
		let request: NSFetchRequest<Entomologist> = Entomologist.fetchRequest()
		request.sortDescriptors = []
		request.predicate = NSPredicate(format: "SELF = %@", objectId)
		return request
	}
	//static func AddCountRecordToEntomology(for entomologist: Entomologist) -> NSFe
}
