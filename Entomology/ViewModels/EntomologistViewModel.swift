//
//  EntomologistViewModel.swift
//  Entomology
//
//  Created by Paul Pacheco on 6/06/23.
//

import Foundation

class EntomologistViewModel: ObservableObject {
	@Published var currentEntomologist: Entomologist?
	#if DEBUG
	private var context = (UITestingHelper.isInPreview || UITestingHelper.isUITesting) ? CoreDataProvider.preview.viewContext : CoreDataProvider.shared.viewContext
	#else
	private var context = UITestingHelper.isUITesting ? CoreDataProvider.preview.viewContext : CoreDataProvider.shared.viewContext
	#endif

	func getUser() {
		let userId = UITestingHelper.isUITesting ? AppData.defaultTestUserId : AppData.defaultUserId
		if !(UITestingHelper.isInPreview || UITestingHelper.isUITesting) {
			if !userId.isEmpty {
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
					print("error \(error)")
				}
			}
		} else {
			do {
				let request = Entomologist.getByName(for: "John")
				let data = try context.fetch(request)
				currentEntomologist = data.first
			} catch {
				print("error \(error)")
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
