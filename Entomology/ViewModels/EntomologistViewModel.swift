//
//  EntomologistViewModel.swift
//  Entomology
//
//  Created by Paul Pacheco on 6/06/23.
//

import Foundation

class EntomologistViewModel: ObservableObject {
	@Published var currentEntomologist: Entomologist?
	private var context = CoreDataProvider.shared.viewContext

	func getUser() {
		if !AppData.defaultUserId.isEmpty {
			guard let id = context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: URL(string: AppData.defaultUserId)!) else {
				return
			}
			do {
				let users = Entomologist.fetchRequest()
				users.sortDescriptors = []
				users.predicate = NSPredicate(format: "SELF = %@", id)
				let data = try context.fetch(users)
				currentEntomologist = data.first

			} catch {
				print("error :v \(error)")
			}
		}
	}

	func saveEntomologist(for entity: Entomologist) {
		do {
			let entomologist = Entomologist(context: context)
			entomologist.name = entity.name
			entomologist.urlPhoto = entity.urlPhoto
			entomologist.geoLocate = entity.geoLocate
			try entomologist.save()
			currentEntomologist = entomologist
			AppData.defaultUserId = entomologist.objectID.uriRepresentation().absoluteString
		} catch {
			print("error saving entomologist: \(error)")
		}
	}
}
