//
//  ModelInsect.swift
//  Entomology
//
//  Created by Paul Pacheco on 2/06/23.
//
import CoreData
import Foundation

class Insect: NSManagedObject {
	func changePhotoUrl(photo: String?) {}

	func changeMoreInfoUrl(info: String?) {}

	func changeGeoLocationPhoto(location: GeoLocation) {}
}

extension Insect {
	@NSManaged var speciesName: String?
	@NSManaged var urlPhoto: String?
	@NSManaged var localePhoto: Data?
	@NSManaged var locate: String?
	@NSManaged var moreInfoUrl: String?
	@NSManaged var countRecords: NSSet?
	@nonobjc public class func fetchRequest() -> NSFetchRequest<Insect> {
		return NSFetchRequest<Insect>(entityName: "Insect")
	}
}

extension Insect: Identifiable {}

extension Insect: Model {
	static func getList() -> NSFetchRequest<Insect> {
		let request = Insect.fetchRequest()
		request.sortDescriptors = []
		return request
	}
	
	static func searchByName(searchTerm: String) -> NSFetchRequest<Insect> {
		let request = Insect.fetchRequest()
		request.sortDescriptors = [NSSortDescriptor(key: "speciesName", ascending: false)]
		request.predicate = NSPredicate(format: "speciesName BEGINSWITH[c] %@", searchTerm)
		return request
	}
}
