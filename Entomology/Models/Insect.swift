//
//  ModelInsect.swift
//  Entomology
//
//  Created by Paul Pacheco on 2/06/23.
//
import CoreData
import Foundation

@objc(Insect)
class Insect: NSManagedObject {
	func changePhotoUrl(photo: String?) {}

	func changeMoreInfoUrl(info: String?) {}

	func changeGeoLocationPhoto(location: GeoLocation) {}
}

extension Insect {
	@NSManaged var speciesName: String?
	@NSManaged var urlPhoto: String?
	@NSManaged var geoLocate: String?
	@NSManaged var moreInfoUrl: String?
	@NSManaged var countRecords: NSSet?
	@nonobjc public class func fetchRequest() -> NSFetchRequest<Insect> {
		return NSFetchRequest<Insect>(entityName: "Insect")
	}
}

extension Insect: Identifiable {}

//extension Insect: Model {
//	static func getByEntomologist(for entomologist: Entomologist) -> NSFetchRequest<Insect> {
//		let request = Insect.fetchRequest()
//		request.sortDescriptors = []
//		request.predicate = NSPredicate(
//	}
//}
