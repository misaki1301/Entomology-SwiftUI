//
//  ModelInsect.swift
//  Entomology
//
//  Created by Paul Pacheco on 2/06/23.
//
import CoreData
import Foundation

class InsectEntity: NSManagedObject {
	func changePhotoUrl(photo: String?) {}

	func changeMoreInfoUrl(info: String?) {}

	func changeGeoLocationPhoto(location: GeoLocation) {}
}

extension InsectEntity {
	@NSManaged var speciesName: String?
	@NSManaged var urlPhoto: String?
	@NSManaged var localePhoto: Data?
	@NSManaged var geoLocate: String?
	@NSManaged var moreInfoUrl: String?
	@NSManaged var countRecords: NSSet?
	@nonobjc public class func fetchRequest() -> NSFetchRequest<InsectEntity> {
		return NSFetchRequest<InsectEntity>(entityName: "Insect")
	}
}

extension InsectEntity: Identifiable {}

extension InsectEntity: Model {
	static func getList() -> NSFetchRequest<InsectEntity> {
		let request = InsectEntity.fetchRequest()
		request.sortDescriptors = []
		return request
	}
}
