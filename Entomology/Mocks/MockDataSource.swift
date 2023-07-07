//
//  MockDataSource.swift
//  Entomology
//
//  Created by Paul Pacheco on 15/06/23.
//

import CoreData
import Foundation
import UIKit

class MockDataSource {
	private let context: NSManagedObjectContext

	init(context: NSManagedObjectContext) {
		self.context = context
	}

	func createUser() throws {
		let insectReq = Insect.fetchRequest()
		let dataInsects = try context.fetch(insectReq)
		let entity = Entomologist(context: context)
		entity.name = "John"
		entity.urlPhoto = UIImage(named: "paul")?.pngData()
		try entity.save()
		// create countrecord
		let count1 = CountRecord(context: context)
		count1.count = 20
		count1.comment = "wow, such amount of insects I found yesterday"
		count1.createdAt = Date()
		count1.entomologist = entity
		count1.location = "Lima, Peru"
		count1.insect = dataInsects[0]

		let count2 = CountRecord(context: context)
		count2.count = 3
		count2.comment = "wow, such amount of insects I found yesterday"
		count2.entomologist = entity
		count2.createdAt = Date()
		count2.location = "Lima, Peru"
		count2.insect = dataInsects[1]
		try context.save()

		AppData.defaultTestUserId = entity.objectID.uriRepresentation().absoluteString
	}

	func createInsects() throws {
		let insect1 = Insect(context: context)
		insect1.geoLocate = "Lima, Peru"
		insect1.moreInfoUrl = "https://es.wikipedia.org/wiki/Anthophila"
		insect1.speciesName = "Abeja"
		insect1.urlPhoto = "https://static.wikia.nocookie.net/agustin-sepulveda-fanon/images/7/7b/Abeja.png/revision/latest/thumbnail/width/360/height/360?cb=20180620011627&path-prefix=es"
		let insect2 = Insect(context: context)
		insect2.geoLocate = "Lima, Peru"
		insect2.moreInfoUrl = "https://es.wikipedia.org/wiki/Morpho"
		insect2.speciesName = "Morpho"
		insect2.urlPhoto = "https://media.istockphoto.com/id/182509255/es/foto/celeste-com%C3%BAn-grande.jpg?s=612x612&w=0&k=20&c=MiKwWOmLfbIcVTYkyDU4i-NTvZTZ6IflrOQLR8pwVpc="
		try context.save()
	}
}
