//
//  MockDataSource.swift
//  Entomology
//
//  Created by Paul Pacheco on 15/06/23.
//

import CoreData
import Foundation
import UIKit

enum CountryPlaces: String {
	case peru
	case usa
	case canada
	case chile
	case colombia
	case japan
}

class MockDataSource {
	private let context: NSManagedObjectContext
	private let genericPlaces: [CountryPlaces: String] =
	[.peru: "Lima, Peru", .usa:"Miami, USA", .canada: "Toronto, Canada",
	 .chile: "Santiago, Chile", .colombia: "Bogota, Colombia", .japan: "Tokyo, Japan"]
	private let comment = "Wow, such amount of insects I found yesterday"
	
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
		
		// create countrecord = 20 abejas
		let count1 = CountRecord(context: context)
		count1.count = 20
		count1.comment = "wow, such amount of insects I found yesterday"
		count1.createdAt = Date()
		count1.entomologist = entity
		count1.location = "Lima, Peru"
		count1.insect = dataInsects.first{$0.speciesName == "Abeja"}

		let count2 = CountRecord(context: context)
		count2.count = 3
		count2.comment = "wow, such amount of insects I found yesterday"
		count2.entomologist = entity
		count2.createdAt = Date()
		count2.location = "Lima, Peru"
		count2.insect = dataInsects.first{$0.speciesName == "Morpho"}
		try context.save()

		AppData.defaultTestUserId = entity.objectID.uriRepresentation().absoluteString
	}

	func createInsects() throws {
		let insect1 = Insect(context: context)
		insect1.locate = genericPlaces[.peru]
		insect1.moreInfoUrl = "https://es.wikipedia.org/wiki/Anthophila"
		insect1.speciesName = "Abeja"
		insect1.urlPhoto = "https://static.wikia.nocookie.net/agustin-sepulveda-fanon/images/7/7b/Abeja.png/revision/latest/thumbnail/width/360/height/360?cb=20180620011627&path-prefix=es"
		let insect2 = Insect(context: context)
		insect2.locate = genericPlaces[.canada]
		insect2.moreInfoUrl = "https://es.wikipedia.org/wiki/Morpho"
		insect2.speciesName = "Morpho"
		insect2.urlPhoto = "https://media.istockphoto.com/id/182509255/es/foto/celeste-com%C3%BAn-grande.jpg?s=612x612&w=0&k=20&c=MiKwWOmLfbIcVTYkyDU4i-NTvZTZ6IflrOQLR8pwVpc="
		let insect3 = Insect(context: context)
		insect3.locate = genericPlaces[.chile]
		insect3.moreInfoUrl = ""
		insect3.speciesName = "Lombriz de tierra"
		insect3.urlPhoto = "https://img.freepik.com/fotos-premium/lombriz-tierra-aislado-blanco_360917-968.jpg"
		let insect4 = Insect(context: context)
		insect4.locate = genericPlaces[.colombia]
		insect4.moreInfoUrl = "https://es.wikipedia.org/wiki/Anthophila"
		insect4.speciesName = "Abeja1"
		insect4.urlPhoto = "https://static.wikia.nocookie.net/agustin-sepulveda-fanon/images/7/7b/Abeja.png/revision/latest/thumbnail/width/360/height/360?cb=20180620011627&path-prefix=es"
		let insect5 = Insect(context: context)
		insect5.locate = genericPlaces[.usa]
		insect5.moreInfoUrl = "https://es.wikipedia.org/wiki/Anthophila"
		insect5.speciesName = "Abeja2"
		insect5.urlPhoto = "https://static.wikia.nocookie.net/agustin-sepulveda-fanon/images/7/7b/Abeja.png/revision/latest/thumbnail/width/360/height/360?cb=20180620011627&path-prefix=es"
		let insect6 = Insect(context: context)
		insect6.locate = genericPlaces[.canada]
		insect6.moreInfoUrl = "https://es.wikipedia.org/wiki/Anthophila"
		insect6.speciesName = "Abeja3"
		insect6.urlPhoto = "https://static.wikia.nocookie.net/agustin-sepulveda-fanon/images/7/7b/Abeja.png/revision/latest/thumbnail/width/360/height/360?cb=20180620011627&path-prefix=es"
		try context.save()
	}
}
