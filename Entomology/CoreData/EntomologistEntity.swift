//
//  ModelEntomologist.swift
//  Entomology
//
//  Created by Paul Pacheco on 1/06/23.
//

import CoreData
import Foundation

public class EntomologistEntity: NSManagedObject {
	func changeUrlPhoto(type: String) {}

	func changeGeoLocationPhoto() {}
}

public extension EntomologistEntity {
	@NSManaged var name: String?
	@NSManaged var urlPhoto: Data?
	@NSManaged var geoLocate: String?
	@NSManaged var countRecords: NSSet?
	@nonobjc class func fetchRequest() -> NSFetchRequest<EntomologistEntity> {
		return NSFetchRequest<EntomologistEntity>(entityName: "Entomologist")
	}
}

extension EntomologistEntity: Identifiable {}

extension EntomologistEntity: Model {
	static func getById(for objectId: NSManagedObjectID) -> NSFetchRequest<EntomologistEntity> {
		let request: NSFetchRequest<EntomologistEntity> = EntomologistEntity.fetchRequest()
		request.sortDescriptors = []
		request.predicate = NSPredicate(format: "SELF = %@", objectId)
		return request
	}
	static func getByName(for name: String) -> NSFetchRequest<EntomologistEntity> {
		let request = EntomologistEntity.fetchRequest()
		request.sortDescriptors = []
		request.predicate = NSPredicate(format: "name == %@", name)
		return request
	}
	//static func AddCountRecordToEntomology(for entomologist: Entomologist) -> NSFe
}
