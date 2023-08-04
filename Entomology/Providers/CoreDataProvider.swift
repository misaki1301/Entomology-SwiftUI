//
//  Persistence.swift
//  Entomology
//
//  Created by Paul Pacheco on 30/05/23.
//

import CoreData
import Foundation

class CoreDataProvider {
	var persistentContainer: NSPersistentContainer

	static let shared = CoreDataProvider()

	var viewContext: NSManagedObjectContext {
		persistentContainer.viewContext
	}
	
	static let currentContext = (UITestingHelper.isRunningUnitTests || UITestingHelper.isInPreview || UITestingHelper.isUITesting) ? CoreDataProvider.preview.viewContext : CoreDataProvider.shared.viewContext

	// A test configuration for SwiftUI previews
	static var preview: CoreDataProvider = {
		let controller = CoreDataProvider(inMemory: true)
		let viewContext = controller.persistentContainer.viewContext
		let mock = MockDataSource(context: viewContext)
		do {
			//create insects
			try? mock.createInsects()
			let req = Insect.getList()
			let dataInsects = try viewContext.fetch(req)
			// create user
			try? mock.createUser()
			// create bugs
			try viewContext.save()
			let request = Entomologist.getByName(for: "John")
			let data = try viewContext.fetch(request)
		} catch {
			let nsError = error as NSError
			fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
		}
		return controller

	}()

	init(inMemory: Bool = false) {
		persistentContainer = NSPersistentContainer(name: "Entomology")
		if inMemory {
			persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
		}
		persistentContainer.loadPersistentStores { _, error in
			if let error {
				fatalError("Unable to initialize Entomology \(error)")
			}
		}
	}
}
